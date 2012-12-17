#import "MasterViewController.h"
#import "Model/Section.h"
#import "BoardViewController.h"
@interface MasterViewController () {
    NSMutableArray *_objects;
    UIAlertView *inputUrlAlert;
    NSString *boardUrl;
    
}
- (void)configureView;
@end

@implementation MasterViewController{
    NSMutableArray *sections;
    
}
@synthesize boardRepository;
#pragma mark - Managing the detail item
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureAlertView
{
    //    if (self.detailItem) {
    //        self.detailDescriptionLabel.text = [self.detailItem description];
    //    }
    
    inputUrlAlert = [[UIAlertView alloc] initWithTitle:@"Enter Url Fragment" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO..!!" , nil];
    inputUrlAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    inputUrlAlert.backgroundColor = [UIColor blackColor];
    [inputUrlAlert show];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Menu";
    [self configureView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        Sticky *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.ideaLabel.text = @"View Demo";
        return cell;
    }
    else{
        Sticky *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.ideaLabel.text = @"View Ideaboard";
        return cell;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
 [self styleStickyCell:(Sticky *)cell withColorIdx:0 andLabel:@"View Demo"];
    [super tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
                                                                    *)indexPath
{
    if(indexPath.row == 0){
        boardUrl = @"/test/2";
        [self performSegueWithIdentifier:@"showSections" sender:self];
     }
    else{
        //alertview
        [self configureAlertView];
        
    }
         
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        boardUrl = [[inputUrlAlert textFieldAtIndex:0] text];
        [self resignFirstResponder];
        [self performSegueWithIdentifier:@"showSections" sender:self];
    
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSections"]) {
        [[segue destinationViewController] setBoardUrl:boardUrl];
    }
}


@end
