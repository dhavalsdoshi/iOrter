#import "SectionViewController.h"
#import "Sticky.h"
#import "FPPopoverController.h"
#import "SectionsPopOver.h"
#import "IdeaboardzService.h"
#import "Idea.h"
@interface SectionViewController ()
- (IBAction)vote:(id)sender;
- (IBAction)deleteIdea:(id)sender;
@end

@implementation SectionViewController{
    Section *selectedSection;
    UISegmentedControl *control;
    IdeaboardzService *service;

}
@synthesize sectionsButton, sections, sectionTitle, titleView, addIdea;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [control setSelectedSegmentIndex:1];
    self.title = [NSString stringWithFormat:@"%@ ▼",selectedSection.name];
//    [self styleTitleView];
    [self getIdeas];

    [self.addIdea setTarget:self];
    self.addIdea.action = @selector(showIdeaEditor:);
}

-(void)navigationTitleTapped
{
 [self popover:self.navigationController.navigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setSelectedSection:(Section *)section  andBoard:(Board *)boardObject {
    selectedSection = section;
    _board = boardObject;
}

-(void)styleTitleView{    
    self.sectionTitle.backgroundColor = [UIColor clearColor];
    self.sectionTitle.font = [UIFont boldSystemFontOfSize:18.0f];
    self.sectionTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.sectionTitle.textAlignment = UITextAlignmentLeft;
    self.sectionTitle.minimumFontSize = 10.0f;
    
    self.sectionTitle.text = selectedSection.name;
    self.navigationItem.titleView = self.titleView;
}

-(void)getIdeas
{
    service = [[IdeaboardzService alloc] initWithBoard:_board parent:self];
    selectedSection.ideas = [service getIdeasForSection:selectedSection.sectionId];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [selectedSection.ideas count];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Idea";
    Sticky *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Sticky alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSString *idea = [[selectedSection.ideas objectAtIndex:indexPath.row] message];

    cell.ideaLabel.font = [UIFont fontWithName:@"Delius" size:20.0];
    cell.ideaLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.ideaLabel.numberOfLines = 0;
    cell.ideaLabel.text = idea;
    cell.ideaLabel.backgroundColor = [UIColor clearColor];
//    cell.deleteButton.frame = CGRectMake(281, 1,15 , 15);
    [cell.deleteButton setTag:indexPath.row];
    [cell.voteButton setTag:indexPath.row];
    NSInteger votes = [[selectedSection.ideas objectAtIndex:indexPath.row] votesCount];
    cell.voteButton.titleLabel.font = [UIFont fontWithName:@"Delius" size:15];
    [cell.voteButton setTitle:[NSString stringWithFormat:@"+%d",votes] forState:UIControlStateNormal];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [[selectedSection.ideas objectAtIndex:indexPath.row] message];
    UIFont *cellFont = [UIFont fontWithName:@"Delius" size:25.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];

    return labelSize.height +30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)self.colors.count;
    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];

    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIndex andLabel:idea];
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(void)popover:(id)sender
{
    //the controller we want to present as a popover
    SectionsPopOver *controller = [[SectionsPopOver alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    popover = [[FPPopoverController alloc] initWithViewController:controller];

    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(300, 500);
    }
    else {
        popover.contentSize = CGSizeMake(200, 300);
    }

    popover.arrowDirection = FPPopoverArrowDirectionAny;

    //sender is the UIButton view    
    [popover presentPopoverFromView:sender];
}

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}

-(void)selectedTableRow:(NSUInteger)rowNum
{
    NSLog(@"SELECTED ROW %d",rowNum);
    if (rowNum == _board.sections.count) return;

    selectedSection = [_board.sections objectAtIndex:rowNum];
    [self.tableView reloadData];
    self.sectionTitle.text = selectedSection.name;
    self.title = [NSString stringWithFormat:@"%@ ▼",selectedSection.name];
    [self getIdeas];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)showIdeaEditor:(id)sender{
    [self performSegueWithIdentifier:@"showIdeaEditor" sender:sender];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIdea = [selectedSection.ideas objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showIdeaEditor" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showIdeaEditor"]) {
        [[segue destinationViewController] setSection:selectedSection andParent:self];
    }
}

- (IBAction)deleteIdea:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Confirm delete"
                                                        message:@"Are you sure you want to delete this item?" delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    UIButton *button = (UIButton *)sender;
    alertView.tag = button.tag;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        _selectedIdea = [selectedSection.ideas objectAtIndex:alertView.tag];
        [service deleteIdeaWithId:_selectedIdea.ideaId];
        _selectedIdea = nil;
        [self viewDidLoad];
        [self.tableView reloadData];
    }
}

-(IBAction)vote:(id)sender
{
    UIButton *button = (UIButton *)sender;
    _selectedIdea = [selectedSection.ideas objectAtIndex:button.tag];
    [service voteForIdeaWithId:_selectedIdea.ideaId];
    _selectedIdea = nil;
}

-(void)didFinish {
    [self getIdeas];
    [self.tableView reloadData];
}

-(void)didProgress:(float)progress{

}

- (void)viewDidUnload {
//     setVoteButton:nil];
    [super viewDidUnload];
}
@end
