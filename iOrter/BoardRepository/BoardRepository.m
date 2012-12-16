//
//  BoardRepository.m
//  iOrter
//
//  Created by Nikita Deshmukh on 07/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//
#import "BoardRepository.h"


@implementation BoardRepository
{

}

@synthesize boardService;

- (id)initWithBoardService:(BoardService *)service andSectionService:(SectionService *)sectionservice
{
    self.boardService = service;
    self.sectionService = sectionservice;
    return self;
}

- (NSMutableArray *)getSectionsForBoard:(NSString *)board
{
    return [self.boardService getSectionsForBoard:board];
}

-(void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    [self.sectionService addIdea:idea toSection:sectionId];
}
@end
