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
    BoardRepository *boardRepository = [[BoardRepository alloc] initWithBoardService:mockForBoardService andSectionService:[[SectionService alloc] init]];

    NSString *boardName = @"test/2";
    
    [[mockForBoardService expect] getSectionsForBoard:boardName];
    
    [boardRepository getSectionsForBoard:boardName];
    
    [mockForBoardService verify];
}

-(void) testShouldAddIdeaToASection
{
    id mockForSectionService = [OCMockObject mockForClass:[SectionService class]];
    BoardRepository *boardRepository = [[BoardRepository alloc] initWithBoardService:[[BoardService alloc] initWithSectionService:mockForSectionService] andSectionService:mockForSectionService];
    
    NSString *idea = @"Test Idea";
    NSInteger sectionId = 4;
    
    [[mockForSectionService expect] addIdea:idea toSection:sectionId];
    
    [boardRepository addIdea:idea toSection:sectionId];
    
    [mockForSectionService verify];
}

@end

