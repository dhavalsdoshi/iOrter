#import "BoardViewController.h"
#import "Service/BoardService.h"
#import "Model/Section.h"
#import "SectionViewController.h"

@interface BoardViewController ()
- (void)configureView;
@end

@implementation BoardViewController
{
    NSMutableArray *sections;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
    sections = [[[BoardService alloc] initWithSectionService:[[SectionService alloc] init]] getSectionsForBoard:@"test/2"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Section"];
    if(cell == Nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Section"];
    cell.textLabel.text = [[sections objectAtIndex:[indexPath row]] name];
    return cell;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sections.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Section *selectedSection = [sections objectAtIndex:indexPath.row];
        [[segue destinationViewController] setSelectedSection:selectedSection andAllSections:sections];
    }
}

@end
