//
//  SectionService.m
//  iOrter
//
//  Created by Yahya Poonawala on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "SectionService.h"
#import "Section.h"
@implementation SectionService

-(NSMutableArray *) getSectionsForBoard:(NSString *)board
{
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ideaboardz.com/for/test/2.json"]] options:kNilOptions error: &error];
    for (NSDictionary *section in [dict objectForKey:@"sections"]) {
        [sections addObject:[[Section alloc] initWithName:[section objectForKey:@"name"]]];
    }
    return sections;
}
@end
