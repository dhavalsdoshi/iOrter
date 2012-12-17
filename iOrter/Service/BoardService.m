#import "BoardService.h"
#import "Section.h"
#import "SectionService.h"

@interface BoardService()

@end

@implementation BoardService{
    SectionService *sectionService;
}

- (id)initWithSectionService:(SectionService *)secService {
    self = [super init];
    sectionService = secService;
    return self;
}

//if URL of board is http://ideaboardz.com/for/board_name/board_id, the board parameter should be "#{board_name}/#{board_id}"
-(NSMutableArray *) getSectionsForBoard:(NSString *)board
{

    board = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                      NULL,
                                                                                                      (CFStringRef)board,
                                                                                                      NULL,
                                                                                                      (CFStringRef)@"!*'();:@&=+$,?%#[]",
                                                                                                      kCFStringEncodingUTF8 ));
    
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    NSMutableString *URLString = [NSMutableString stringWithString: @"http://ideaboardz.com/for"];
    [URLString appendString:board];
    [URLString appendString:@".json"];
    NSURL *boardJSONURL = [NSURL URLWithString:URLString];
    NSData *boardJSONString = [NSData dataWithContentsOfURL:boardJSONURL];
    NSError *error;
    NSDictionary *boardJSONDictionary = [NSJSONSerialization JSONObjectWithData:boardJSONString options:kNilOptions error:&error];
    NSDictionary *sectionsAndIdeas = [sectionService getSectionWiseIdeasForBoard:board];

    id <NSFastEnumeration> allSections = [boardJSONDictionary objectForKey:@"sections"];
    for (NSDictionary *section in allSections) {
        id keySectionID = [section objectForKey:@"id"];
        NSInteger *sectionID =  (NSInteger *)[[keySectionID stringValue] intValue];
        NSString *sectionName = [section objectForKey:@"name"];
        Section *newSection = [[Section alloc] initWithId:sectionID name:sectionName];
        newSection.ideas = [sectionsAndIdeas objectForKey:keySectionID];
        [sections addObject:newSection];
    }
    return sections;
}
@end
