//
//  BoardRepository.m
//  iOrter
//
//  Created by Nikita Deshmukh on 07/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//
#import "BoardRepository.h"
#import "Board.h"


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

- (NSMutableArray *)getSectionsForBoard:(Board *)board
{
    return [self.boardService getSections];
}

-(void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    [self.sectionService addIdea:idea toSection:sectionId];
}
@end
