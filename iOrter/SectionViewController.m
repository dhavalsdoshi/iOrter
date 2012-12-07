#import "SectionViewController.h"
#import "Service/SectionService.h"
#import "IdeaCell.h"
@interface SectionViewController ()

@end

@implementation SectionViewController{
    Section *selectedSection;
    NSMutableArray *sections;
    SectionService *sectionService;
    NSMutableArray *colors;
    IdeaCell *cell;
}

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
    sectionService = [[SectionService alloc] init];
    colors = [NSMutableArray array];
    [colors addObject:[UIColor colorWithRed:1.0 green:1.0 blue:0.5 alpha:1.0]];
    [colors addObject:[UIColor orangeColor]];
    [colors addObject:[UIColor colorWithRed:0.73 green:0.93 blue:0.41 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.81 green:0.49 blue:0.87 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0]];
    [colors addObject:[UIColor colorWithRed:0.09 green:0.71 blue:1.0 alpha:1.0]];
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
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[IdeaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *idea = [selectedSection.ideas objectAtIndex:indexPath.row];
    cell.ideaLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    cell.ideaLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.ideaLabel.numberOfLines = 0;
    cell.ideaLabel.text = idea;
    NSInteger colorIndex = (int)selectedSection.sectionId %  (int)colors.count;
    cell.ideaView.backgroundColor = [colors objectAtIndex:colorIndex];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setSeparatorColor:[UIColor whiteColor]];
    NSString *cellText = [selectedSection.ideas objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    return labelSize.height + 40;
    
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

- (IBAction)showActionSheet {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] init];
    popupQuery = [popupQuery initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for(Section *section in sections){
        [popupQuery addButtonWithTitle:section.name];
    }
    [popupQuery addButtonWithTitle:@"Cancel"];
    popupQuery.cancelButtonIndex = sections.count;
    popupQuery.actionSheetStyle = UIActionSheetStyleAutomatic;
    [popupQuery showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == sections.count) return;
    selectedSection = [sections objectAtIndex:buttonIndex];
    [self.tableView reloadData];
    self.title = selectedSection.name;
}

@end
