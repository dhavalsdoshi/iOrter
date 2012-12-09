#import "SectionViewController.h"
#import "BoardRepository.h"
#import "IdeaCell.h"
#import "FPPopoverController.h"
#import "SectionsPopOver.h"

@interface SectionViewController ()

@end

@implementation SectionViewController{
    Section *selectedSection;
    NSMutableDictionary *stickyColors;
    BoardRepository *board;
    NSMutableArray *colors;
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
    colors = [NSMutableArray array];
//    [colors addObject:[UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1.0]];
//    [colors addObject:[UIColor orangeColor]];
//    [colors addObject:[UIColor colorWithRed:0.73 green:0.93 blue:0.41 alpha:1.0]];
//    [colors addObject:[UIColor colorWithRed:0.81 green:0.49 blue:0.87 alpha:1.0]];
//    [colors addObject:[UIColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0]];
//    [colors addObject:[UIColor colorWithRed:0.09 green:0.71 blue:1.0 alpha:1.0]];
    self.title = selectedSection.name;

    [colors addObject:@"stickyBlue.png"];
    [colors addObject:@"stickyGreen.png"];
    [colors addObject:@"stickyYellow.png"];
    [colors addObject:@"stickyOrange.png"];


//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"notesBg.png"]];
//    self.view.backgroundColor = background;
    self.tableView.separatorColor = [UIColor clearColor];

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
    IdeaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[IdeaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    IdeaCell *currentCell = (IdeaCell*)cell;

    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)colors.count;
    NSString *imageName = [colors objectAtIndex:colorIndex];
    UIImage *bgImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 15, 10, 24)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];

    CGSize  textSize = { 260.0, 10000.0 };
    CGSize size = [idea sizeWithFont:[UIFont fontWithName:@"Georgia-Italic" size:17.0]
                   constrainedToSize:textSize
                       lineBreakMode:UILineBreakModeWordWrap];
    float padding = 20.0;
    size.width += (padding/2);
    [currentCell.stickyBg setFrame:CGRectMake(currentCell.ideaLabel.frame.origin.x - padding/2,
                                       currentCell.ideaLabel.frame.origin.y - padding/2,
                                       size.width+padding,
                                       size.height+padding)];
//    currentCell.stickyBg.transform = CGAffineTransformMakeRotation(M_PI / 180 * 1);
    currentCell.stickyBg.image = bgImage;


}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(IdeaCell *)ideaCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
     */
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    [self popover:sender];
}

@end
