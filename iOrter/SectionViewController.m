#import "SectionViewController.h"
#import "BoardRepository.h"
#import "Sticky.h"
#import "FPPopoverController.h"
#import "SectionsPopOver.h"

@interface SectionViewController ()

@end

@implementation SectionViewController{
    Section *selectedSection;
    NSMutableDictionary *stickyColors;
    BoardRepository *board;
    NSDictionary *sectionwiseIdeas;
}
@synthesize sectionsButton, sections, sectionTitle, titleView;

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
    [[NSBundle mainBundle] loadNibNamed:@"TitleView" owner:self options:nil];
    board = [[BoardRepository alloc] init];

    self.sectionTitle.backgroundColor = [UIColor clearColor];

    self.sectionTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    self.sectionTitle.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.sectionTitle.textAlignment = UITextAlignmentLeft;
    self.sectionTitle.minimumFontSize = 10.0f;

    self.sectionTitle.text = selectedSection.name;
    self.navigationItem.titleView = self.titleView;
    
    NSLog(@"view did Load");
    [self getIdeas];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getIdeas
{
    
    BoardService *boardService = [[BoardService alloc] initWithBoard:_board];
    selectedSection.ideas = [boardService getIdeasForSection:selectedSection.sectionId];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Idea";
    Sticky *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[Sticky alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];

    cell.ideaLabel.font = [UIFont fontWithName:@"Georgia-Italic" size:17.0];
    cell.ideaLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.ideaLabel.numberOfLines = 0;
    cell.ideaLabel.text = idea;
    cell.ideaLabel.backgroundColor = [UIColor clearColor];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [selectedSection.ideas objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Georgia-Italic" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    if (labelSize.height==0) {
        return 44;
    }
    return labelSize.height + 40;
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)self.colors.count;
    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];

    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIndex andLabel:idea];
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)setSelectedSection:(Section *)section  andBoard:(Board *)boardObject {
    selectedSection = section;
    _board = boardObject;
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
    [self getIdeas];
    [self.tableView reloadData];
    [popover dismissPopoverAnimated:YES];
}

-(IBAction)showPopOver:(id)sender{
    [self popover:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"I am in BoardViewController.prepareForSeque");
    if ([[segue identifier] isEqualToString:@"addIdea"]) {
        [[segue destinationViewController] setSection:selectedSection andParent:self];
    }
}

@end
