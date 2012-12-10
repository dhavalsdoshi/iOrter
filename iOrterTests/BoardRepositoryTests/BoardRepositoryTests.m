//
//  BoardRepositoryTests.m
//  iOrter
//
//  Created by Nikita Deshmukh on 07/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//
# import "BoardRepository.h"
#import "BoardRepositoryTests.h"

@implementation BoardRepositoryTests


- (void)testShouldGetSectionsFromBoard
{
    id mockForBoardService = [OCMockObject mockForClass:[BoardService class]];
    BoardRepository *boardRepository = [[BoardRepository alloc] initWithService:mockForBoardService];

    NSString *boardName = @"test/2";
    
    [[mockForBoardService expect] getSectionsForBoard:boardName];
    
    [boardRepository getSectionsForBoard:boardName];
    
    [mockForBoardService verify];
}
@end

