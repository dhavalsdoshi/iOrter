//
//  BoardViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 14/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "Board.h"

@interface BoardViewController : BaseTableViewController
@property (nonatomic,strong) NSString *boardName;
@property (nonatomic,strong) NSString *boardUrl;
@property (nonatomic,strong) Board *board;
-(void)setBoardId:(NSInteger)identifier name:(NSString *)name;
@end
