//
//  ContributeIdeaViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "ContributeIdeaViewController.h"
#import "MBProgressHUD.h"
#import "IdeaboardzService.h"

@interface ContributeIdeaViewController (){
    Section *selectedSection;
    MBProgressHUD *hud;
    Idea *selectedIdea;
    NSInteger editFlag;
}
- (IBAction)doneButtonPressed:(id)sender;

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
    [_parent addShadow:self.ideaText];
    NSInteger colorIdx = (int)selectedSection.sectionId % _parent.colors.count;
    self.ideaText.backgroundColor = [self.parent.colors objectAtIndex:colorIdx];
    self.ideaText.text = selectedIdea.message;
    if (selectedIdea!=nil) {
        editFlag = 1;
    }
    else editFlag = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)setSection:(Section *)section idea:(Idea *)idea andParent:(SectionViewController *)parent;
{
    selectedSection = section;
    self.navigationItem.title = selectedSection.name;
    selectedIdea = idea;
    self.parent = parent;
}

-(void) dismissKeyboard
{
    [self.ideaText resignFirstResponder];
    
}

-(IBAction)cancelAdding:(id)sender
{
    [self.parent viewDidLoad];
    [self.parent.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}


-(IBAction)doneButtonPressed:(id)sender
{
    [self dismissKeyboard];
    IdeaboardzService *boardService = [[IdeaboardzService alloc] initWithParent:self];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    NSString *idea = [self.ideaText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (editFlag == 0) {
        if (idea.length != 0) {
            
            hud.labelText = @"Posting..";
            [boardService addIdea:idea toSection:selectedSection.sectionId];
        }

    }
    else{
        
        hud.labelText = @"Editing..";
        selectedIdea.message = self.ideaText.text;
        [boardService editIdeaWithId:selectedIdea.ideaId message:selectedIdea.message];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(cancelAdding:) userInfo:nil repeats:NO];

//        [self cancelAdding:self];
    }
}
 
-(void)didProgress:(float)progress{
    hud.progress = progress;
}

-(void)didFinish {
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Done!";
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(clearProgressMessage) userInfo:nil repeats:NO];
    self.ideaText.text = @"";
    
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
