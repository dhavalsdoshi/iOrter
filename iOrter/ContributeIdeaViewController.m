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
    MBProgressHUD *hud;
}
- (IBAction)addIdea:(id)sender;

@end

@implementation ContributeIdeaViewController


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
    NSInteger colorIdx = 0;//(int)selectedSection.sectionId % _parent.colors.count;
    NSString *imageName = [self.parent.colors objectAtIndex:colorIdx];
    UIImage *bgImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 15, 10, 24)];
    
    self.ideaImageView.image = bgImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)setSection:(Section *)section andParent:(SectionViewController *)parent
{
    selectedSection = section;
    self.navigationItem.title = selectedSection.name;
    self.parent = parent;
}

-(void) dismissKeyboard
{
    [self.ideaText resignFirstResponder];
    
}

-(IBAction)cancelAdding:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];

}


-(IBAction)addIdea:(id)sender
{
    [self dismissKeyboard];
    
    NSString *idea = [self.ideaText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (idea.length != 0) {
        SectionService *sectionService = [[SectionService alloc] initWithParent:self];
        BoardService *boardService = [[BoardService alloc] initWithSectionService:sectionService];
        BoardRepository *board = [[BoardRepository alloc] initWithBoardService:boardService andSectionService:sectionService];
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Posting..";
        
        [board addIdea:idea toSection:selectedSection.sectionId];
        
        NSLog(@"Adding idea : %@", idea);
    }
}
 
-(void)didProgress:(float)progress{
    hud.progress = progress;
}

-(void)didFinish {
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Done!";
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(clearProgressMessage) userInfo:nil repeats:NO];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)didFail:(NSString *)data {
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Failed to post; try again..";
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(clearProgressMessage) userInfo:nil repeats:NO];
}

- (void) clearProgressMessage {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)viewDidUnload {
    [self setIdeaImageView:nil];
    [super viewDidUnload];
}
@end
