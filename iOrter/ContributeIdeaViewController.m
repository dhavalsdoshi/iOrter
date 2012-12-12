//
//  ContributeIdeaViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "ContributeIdeaViewController.h"
#import "BoardRepository.h"
@interface ContributeIdeaViewController (){
    NSInteger *sectionId;
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

-(void)setSectionIdentifier:(NSInteger *)sectionIdentifier
{
    sectionId = sectionIdentifier;
}

-(void) dismissKeyboard
{
    [self.ideaText resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]){
        [self.ideaText resignFirstResponder];
        [self addIdea:self];
    }
    return YES;
}

-(void)addIdea:(id)sender
{
    self.idea = ideaText.text;
    SectionService *sectionService = [[SectionService alloc] init];
    BoardService *boardService = [[BoardService alloc] initWithSectionService:sectionService];
    BoardRepository *board = [[BoardRepository alloc] initWithBoardService:boardService andSectionService:sectionService];
    [board addIdea:self.idea toSection:sectionId];
    NSLog(@"%@",self.idea);
    [self dismissModalViewControllerAnimated:YES];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
}
@end
