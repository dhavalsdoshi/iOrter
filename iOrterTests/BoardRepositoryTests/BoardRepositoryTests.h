//
//  BoardRepositoryTests.h
//  iOrter
//
//  Created by Nikita Deshmukh on 07/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//
#import "OCMock/OCMock.h"
#import <SenTestingKit/SenTestingKit.h>
#import "SectionService.h"
#import "Section.h"
#import "BoardService.h"

@interface BoardRepositoryTests : SenTestCase
- (void)testShouldGetIdeasFromSectionService;
- (void)testShouldGetSectionsFromBoard;
@end
