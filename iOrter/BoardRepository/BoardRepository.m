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


- (NSMutableArray *)getSectionsForBoard:(NSString *)board
{
    sections = [[[BoardService alloc] initWithSectionService:[[SectionService alloc]init]] getSectionsForBoard:@"test/2"];
    return sections;
}
@end
