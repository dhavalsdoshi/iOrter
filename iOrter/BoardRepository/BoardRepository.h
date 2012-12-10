//
//  BoardRepository.h
//  iOrter
//
//  Created by Nikita Deshmukh on 07/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionService.h"
#import "BoardService.h"
@interface BoardRepository : NSObject
@property (nonatomic, strong) BoardService *boardService;
- (id)initWithService:(BoardService *)service;
- (NSMutableArray *)getSectionsForBoard:(NSString *)board;

@end
