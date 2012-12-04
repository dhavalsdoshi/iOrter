#import "SectionService.h"
#import "Section.h"

@implementation SectionService

- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board {
    NSMutableString *URLString = [NSMutableString stringWithString: @"http://ideaboardz.com/retros/"];
    [URLString appendString:board];
    [URLString appendString:@"/points.json"];
    NSURL *boardJSONURL = [NSURL URLWithString:URLString];
    NSData *boardJSON = [NSData dataWithContentsOfURL:boardJSONURL];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:boardJSON options:kNilOptions error:&error];
    NSMutableDictionary *sectionWiseIdeas = [[NSMutableDictionary alloc] init];
    for(NSDictionary *idea in dict)
    {
        id <NSCopying> sectionId = [idea objectForKey:@"section_id"];
        NSMutableArray *ideas = [sectionWiseIdeas objectForKey:sectionId];
        if(ideas == Nil){
            ideas = [[NSMutableArray alloc] init];
            [sectionWiseIdeas setObject:ideas forKey:sectionId];
        }
        [ideas addObject:[idea objectForKey:@"message"]];
    }
    return sectionWiseIdeas;
}
@end
