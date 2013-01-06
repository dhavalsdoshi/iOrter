//
//  ContributeIdeaViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SectionViewController.h"
#import "HttpClientService.h"
#import "Idea.h"


@class SectionViewController;
@interface IdeaEditorViewController : UIViewController <UITextViewDelegate, HttpTaskDelegate>

@property (nonatomic) IBOutlet UITextView *ideaText;
//@property (weak, nonatomic) IBOutlet UIImageView *ideaImageView;
@property (nonatomic, strong) SectionViewController *parent;
@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *back;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *done;

-(void)setSection:(Section *)section andParent:(SectionViewController *)parent;

-(IBAction)cancelAdding:(id)sender;
-(IBAction)doneButtonPressed:(id)sender;
@end
