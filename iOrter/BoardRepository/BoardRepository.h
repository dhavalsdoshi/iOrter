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

- (id)initWithSectionService:(SectionService *)secService;
- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board;
- (NSMutableArray *)getSectionsForBoard:(NSString *)board;

@end
