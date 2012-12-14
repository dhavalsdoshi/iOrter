//
//  BoardViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 14/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface BoardViewController : BaseTableViewController
@property (nonatomic,strong) NSString *boardName;
-(void) setBoardName:(NSString *)boardName;
@end
