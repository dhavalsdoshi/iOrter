//
//  SectionsPopOver.h
//  iOrter
//
//  Created by Rajdeep Kwatra on 09/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionViewController;

@interface SectionsPopOver : UITableViewController

@property(nonatomic,assign) SectionViewController *delegate;
@end
