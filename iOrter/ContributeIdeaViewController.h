//
//  ContributeIdeaViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
@class SectionViewController;
@interface ContributeIdeaViewController : UIViewController <UITextViewDelegate>
@property (nonatomic) IBOutlet UITextView *ideaText;
@property (nonatomic, strong) NSString *idea;
@property (nonatomic, strong)  MasterViewController *delegate;
-(void)setSection:(Section *)section;
-(IBAction)cancelAdding:(id)sender;
@end
