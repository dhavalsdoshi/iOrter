//
//  BaseTableViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 10/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sticky.h"
#import "MBProgressHUD.h"

@interface BaseTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *colors;

- (void)styleStickyCell:(Sticky *)cell withColorIdx:(NSInteger)colorIdx andLabel:(NSString *)label;
- (void) addShadow:(UIView *)viewToStyle;
-(UIColor*)colorWithHexString:(NSString*)hex;

- (void) displayProgressMessage: (NSString*) message;
- (void) clearProgressMessage;
- (void) setTitle:(NSString *)title;
- (void) navigationTitleTapped;

@end
