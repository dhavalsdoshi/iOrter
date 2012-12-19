#import "MasterViewController.h"
#import "Model/Section.h"
#import "BoardViewController.h"
@interface MasterViewController () {

    
}

@end

@implementation MasterViewController{
    NSMutableArray *sections;
    UIAlertView *inputUrlAlert;
    NSString *boardName;
    NSInteger boardId;
    
}

- (void)configureAlertView
{
    
    inputUrlAlert = [[UIAlertView alloc] initWithTitle:@"Enter Board Details" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO..!!" , nil];
    inputUrlAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    inputUrlAlert.backgroundColor = [UIColor blackColor];
    UITextField *boardNameTextField = [inputUrlAlert textFieldAtIndex:0];
    boardNameTextField.placeholder = @"Board Name";
    UITextField *boardIdTextField = [inputUrlAlert textFieldAtIndex:1];
    boardIdTextField.placeholder = @"Board ID";
    boardIdTextField.secureTextEntry = NO;
    
    [inputUrlAlert show];
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
    Sticky *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = (Sticky*)[[UITableViewCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:@"Cell"];
    }
    
    if(indexPath.row == 0)
    {

        cell.ideaLabel.text = @"View Demo";
    }
    else{
        cell.ideaLabel.text = @"View Ideaboard";

    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSInteger colorIdx = (int)indexPath.row %  (int)self.colors.count;
    cell = (Sticky *)cell;
    
    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIdx andLabel:cell.textLabel.text];
    [super tableView:tableView willDisplayCell:(Sticky *)cell forRowAtIndexPath:indexPath];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
                                                                    *)indexPath
{
    if(indexPath.row == 0){
        boardName = @"test";
        boardId = 2;
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
        boardName = [[inputUrlAlert textFieldAtIndex:0] text];
        NSString *Id = [[inputUrlAlert textFieldAtIndex:1] text];
        boardId = [Id integerValue];
        [self resignFirstResponder];
        [self performSegueWithIdentifier:@"showSections" sender:self];
    
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showSections"]) {
        [[segue destinationViewController] setBoardId:boardId name:boardName];
    }
}


@end
