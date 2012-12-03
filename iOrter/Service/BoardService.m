#import "BoardService.h"
#import "Section.h"
@implementation BoardService

-(NSMutableArray *) getSectionsForBoard:(NSString *)board
{
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ideaboardz.com/for/test/2.json"]] options:kNilOptions error: &error];
    for (NSDictionary *d in [dict objectForKey:@"sections"]) {
        [sections addObject:[[Section alloc] initWithName:[d objectForKey:@"name"]]];
    }
    return sections;
}
@end
