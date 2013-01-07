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
    return 5;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        return 133;
    }
    else if(indexPath.row==1){
        return 80;
    }
    return 65;
}
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (Sticky *)cell;
    cell.textLabel.font = [UIFont fontWithName:@"Handlee" size:25.0];

    NSInteger colorIdx = (int)indexPath.row %  (int)self.colors.count;
    if(indexPath.row!=0){
    [self styleStickyCell:(Sticky *)cell withColorIdx:colorIdx andLabel:cell.textLabel.text];
    

        [super tableView:tableView willDisplayCell:(Sticky *)cell forRowAtIndexPath:indexPath];
//        Rotate cell at random angle betwee +2 and -2 degrees
        int i;
        if (indexPath.row == 1 || indexPath.row == 4) {
            i = (arc4random()%2)+(3);
        }
        else{
            i = (arc4random()%2)+(-2);
        }
    float rotation = i/100.0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGAffineTransform rr=CGAffineTransformMakeRotation(rotation);
    cell.transform=CGAffineTransformConcat(cell.transform, rr);
    [UIView commitAnimations];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath
                                                                    *)indexPath
{
    if(indexPath.row == 1){
        boardName = @"test";
        boardId = 2;
        [self performSegueWithIdentifier:@"showSections" sender:self];
     }
    else if(indexPath.row ==2){
        //alertview
        [self configureAlertView];
        
    }
    else if (indexPath.row == 3){
        boardName = @"feedback";
        boardId = 1;
        [self performSegueWithIdentifier:@"showSections" sender:self];
    }
    else if(indexPath.row == 4){
        [self performSegueWithIdentifier:@"showFaq" sender:self];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ideaboardz.com/page/faq"]];
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
    else if ([[segue identifier] isEqualToString:@"showFaq"]){
        [segue destinationViewController];
    }
}


@end
