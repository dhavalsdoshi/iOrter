//
//  JsonParser.m
//  iOrter
//
//  Created by Nikita Deshmukh on 20/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "BoardJsonParser.h"
#import "Section.h"

@implementation BoardJsonParser{
}
-(id)init{
    if(self = [super init]){
        _array = [NSMutableArray array];

    }
    return self;
}
-(NSMutableArray *) parseToSections:(NSData *)data;
{
    
    NSError *error;

    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    id <NSFastEnumeration> allSections = [dictionary objectForKey:@"sections"];
    for (NSDictionary *section in allSections) {
        id keySectionID = [section objectForKey:@"id"];
        NSInteger *sectionID =  (NSInteger *)[[keySectionID stringValue] intValue];
        NSString *sectionName = [section objectForKey:@"name"];
        Section *newSection = [[Section alloc] initWithId:sectionID name:sectionName];
        [_array addObject:newSection];
    }
    return _array;
}

-(NSMutableArray *) parseToIdeas:(NSData *)data ofSection:(NSInteger)sectionId
{
    NSError *error;
    NSMutableArray *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    for (NSDictionary *idea in dictionary) {
        NSString *Id = [idea objectForKey:@"section_id"];
        NSInteger section_id = [Id integerValue];
        if(section_id == sectionId){
            NSString *point = [idea valueForKey:@"message"];
            [_array addObject:point];
        }
        
    }
    return _array;

}

@end
