#import "BoardService.h"
#import "Section.h"
@implementation BoardService

-(NSMutableArray *) getSectionsForBoard:(NSString *)board
{
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    NSURL *boardJSONURL = [NSURL URLWithString:@"http://ideaboardz.com/for/test/2.json"];
    NSData *boardJSON = [NSData dataWithContentsOfURL:boardJSONURL];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:boardJSON options:kNilOptions error:&error];
    id <NSFastEnumeration> allSections = [dict objectForKey:@"sections"];
    for (NSDictionary *section in allSections) {
        NSInteger *sectionID =  (NSInteger *)[[[section objectForKey:@"id"] stringValue] intValue];
        NSString *sectionName = [section objectForKey:@"name"];
        Section *newSection = [[Section alloc] initWithId:sectionID name:sectionName];
        [sections addObject:newSection];
    }
    return sections;
}
@end
