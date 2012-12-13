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
@synthesize sectionsButton, sections;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    board = [[BoardRepository alloc] init];
    self.title = selectedSection.name;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selectedSection.ideas.count;
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
    
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)colors.count;
    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];

    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIndex andLabel:idea];
}

- (void)setSelectedSection:(Section *)section  andAllSections:(NSMutableArray *)allSections {
    selectedSection = section;
    sections = allSections;
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
    if (rowNum == sections.count) return;

    selectedSection = [sections objectAtIndex:rowNum];
    [self.tableView reloadData];
    self.title = selectedSection.name;

    [popover dismissPopoverAnimated:YES];
}

-(IBAction)showPopOver:(id)sender{
    UISegmentedControl *control = (UISegmentedControl *) sender;
    
    if ([control selectedSegmentIndex]==1){
        [self performSegueWithIdentifier:@"addIdea" sender:control];

    }
    else{
        [self popover:sender];

    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addIdea"]) {
        NSInteger *sectionId = selectedSection.sectionId;
        [[segue destinationViewController] setSection:selectedSection andParent:self.view];
    }
}

@end
