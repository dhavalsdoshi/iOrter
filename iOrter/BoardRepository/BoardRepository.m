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
    SectionService *sectionService;
    NSMutableArray *sections;
}

@synthesize boardService;

- (id)initWithService:(BoardService *)service {
    self.boardService = service;
    return self;
}

- (NSMutableArray *)getSectionsForBoard:(NSString *)board
{
    return [self.boardService getSectionsForBoard:@"test/2"];
}
@end
