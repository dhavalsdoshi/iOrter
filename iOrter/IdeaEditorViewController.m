//
//  ContributeIdeaViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "IdeaEditorViewController.h"
#import "MBProgressHUD.h"
#import "IdeaboardzService.h"

@interface IdeaEditorViewController (){
    Section *selectedSection;
    MBProgressHUD *hud;
    Idea *selectedIdea;
    NSInteger editFlag;
}
- (IBAction)doneButtonPressed:(id)sender;

@end

@implementation IdeaEditorViewController
@synthesize back, done;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self addGestures];

    [self.back setTarget:self];
    self.back.action = @selector(cancelAdding:);
    [self.done setTarget:self];
    self.done.action = @selector(doneButtonPressed:);
    
    [self setSelectedIdea];
    [_parent addShadow:self.ideaText];
    
    [self setStickyBackground];
}

- (void)addGestures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)setStickyBackground
{
    NSInteger colorIdx = (int)selectedSection.sectionId % _parent.colors.count;
    self.ideaText.backgroundColor = [self.parent.colors objectAtIndex:colorIdx];
}

- (void)setSelectedIdea
{
    selectedIdea = _parent.selectedIdea;
    if (selectedIdea!=nil) {
        editFlag = 1;
        self.ideaText.text = selectedIdea.message;
    }
    else editFlag = 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
-(void)setSection:(Section *)section andParent:(SectionViewController *)parent;
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
    self.parent.selectedIdea = nil;
    selectedIdea = nil;
    
    [self.parent viewDidLoad];
    [self.parent.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}


- (void)configureHud
{
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)addIdea:(NSString *)idea usingBoardService:(IdeaboardzService *)boardService
{
    hud.labelText = @"Posting..";
    [boardService addIdea:idea toSection:selectedSection.sectionId];
}

- (void)editIdeaUsingService:(IdeaboardzService *)boardService
{
    hud.labelText = @"Editing..";
    selectedIdea.message = self.ideaText.text;
    [boardService editIdeaWithId:selectedIdea.ideaId message:selectedIdea.message];
}

-(IBAction)doneButtonPressed:(id)sender
{
    [self dismissKeyboard];
    IdeaboardzService *boardService = [[IdeaboardzService alloc] initWithParent:self];    
    [self configureHud];
    
    NSString *idea = [self.ideaText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (editFlag == 0) {
        if (idea.length != 0) {            
            [self addIdea:idea usingBoardService:boardService];
        }
    }
    else{
        [self editIdeaUsingService:boardService];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(cancelAdding:) userInfo:nil repeats:NO];
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
//    [self setIdeaImageView:nil];
    [super viewDidUnload];
}
@end
