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
@interface ContributeIdeaViewController : UIViewController <UITextViewDelegate, HttpTaskDelegate>

@property (nonatomic) IBOutlet UITextView *ideaText;
@property (weak, nonatomic) IBOutlet UIImageView *ideaImageView;
@property (nonatomic, strong)  SectionViewController *parent;
@property (nonatomic, strong)  UIView *parentView;


-(void)setSection:(Section *)section idea:(Idea *)idea andParent:(SectionViewController *)parent;
-(IBAction)cancelAdding:(id)sender;
@end
