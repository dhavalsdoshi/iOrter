//
//  BaseTableViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 10/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sticky.h"
@interface BaseTableViewController : UITableViewController
{
    NSMutableArray *colors;

}
- (void)styleStickyCell:(Sticky *)cell withColorIdx:(NSInteger)colorIdx andLabel:(NSString *)idea;
@end
