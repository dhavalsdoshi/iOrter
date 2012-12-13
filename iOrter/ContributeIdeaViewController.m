//
//  ContributeIdeaViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "ContributeIdeaViewController.h"
#import "BoardRepository.h"
#import "MBProgressHUD.h"

@interface ContributeIdeaViewController (){
    Section *selectedSection;
}
- (IBAction)addIdea:(id)sender;

@end

@implementation ContributeIdeaViewController

@synthesize ideaText, idea, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)setSection:(Section *)section andParent:(UIView *)view
{
    selectedSection = section;
    self.navigationItem.title = selectedSection.name;
    self.parentView = view;
}

-(void) dismissKeyboard
{
    [self.ideaText resignFirstResponder];
}

-(IBAction)cancelAdding:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];

}

- (void) clearProgressMessage {
    [MBProgressHUD hideHUDForView:self.parentView animated:YES];
}

-(IBAction)addIdea:(id)sender
{
    self.idea = ideaText.text;
    SectionService *sectionService = [[SectionService alloc] initWithView:self.parentView];
    BoardService *boardService = [[BoardService alloc] initWithSectionService:sectionService];
    BoardRepository *board = [[BoardRepository alloc] initWithBoardService:boardService andSectionService:sectionService];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Posting..";
    
    [board addIdea:self.idea toSection:selectedSection.sectionId
        progress:^(float progress) {
            hud.progress = progress;
        } complete:^{
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"Done!";
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(clearProgressMessage) userInfo:nil repeats:NO];
        }];

    
    NSLog(@"%@",self.idea);
    [self dismissModalViewControllerAnimated:YES];
}
@end
