#import "BoardService.h"
#import "Section.h"
#import "SectionService.h"
#import "HttpClient.h"
#import "Board.h"

@interface BoardService()

@end

@implementation BoardService{
    SectionService *sectionService;
}

-(id) initWithBoard:(Board *)boardObject{
    self = [super init];
    self.board = boardObject;
    return self;
}
-(id) initWithParent:(id)par {
    self = [super init];
    if (self) {
        self.parent = par;
    }
    return self;
}


//if URL of board is http://ideaboardz.com/for/board_name/board_id, the board parameter should be "#{board_name}/#{board_id}"
-(NSMutableArray *) getSections
{

    NSURL *boardUrl = [self urlForBoard];
    
    NSMutableArray *sections = [NSMutableArray arrayWithCapacity:10];
    NSData *boardJSONString;
    
    HttpClient *client = [[HttpClient alloc] init];
    boardJSONString = [client getDataFrom:boardUrl];
    
    
    NSError *error;
    NSDictionary *boardJSONDictionary = [NSJSONSerialization JSONObjectWithData:boardJSONString options:kNilOptions error:&error];
//    NSDictionary *sectionsAndIdeas = [sectionService getSectionWiseIdeasForBoard:board];

    id <NSFastEnumeration> allSections = [boardJSONDictionary objectForKey:@"sections"];
    for (NSDictionary *section in allSections) {
        id keySectionID = [section objectForKey:@"id"];
        NSInteger *sectionID =  (NSInteger *)[[keySectionID stringValue] intValue];
        NSString *sectionName = [section objectForKey:@"name"];
        Section *newSection = [[Section alloc] initWithId:sectionID name:sectionName];
//        newSection.ideas = [sectionsAndIdeas objectForKey:keySectionID];
        [sections addObject:newSection];
    }
    return sections;
}

-(NSMutableArray *) getIdeasForSection:(NSInteger)sectionId{
   
    NSURL *ideaUrl = [self urlForIdeas];
    HttpClient *client = [[HttpClient alloc] init];
    NSData *jsonIdeas = [client getDataFrom:ideaUrl];
    NSError *error;
   
    NSMutableArray *ideas = [[NSMutableArray alloc] initWithCapacity:10];
    NSMutableArray *allIdeas = [NSJSONSerialization JSONObjectWithData:jsonIdeas options:kNilOptions error:&error];

    for (NSDictionary *idea in allIdeas) {
        NSString *Id = [idea objectForKey:@"section_id"];
        NSInteger section_id = [Id integerValue];
        if(section_id == sectionId){
            NSString *point = [idea valueForKey:@"message"];
            [ideas addObject:point];
        }
        
    }

    return ideas;
    
    
}
//Request URL:http://ideaboardz.com/retros/test/2/points.json


-(NSURL *)urlForIdeas
{
    NSString *url = [NSString stringWithFormat:@"http://www.ideaboardz.com/retros/%@/%d/points.json",_board.boardName,_board.boardId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                NULL,
                                                                                (CFStringRef)url,
                                                                                NULL,
                                                                                (CFStringRef)@"!*'();@&=+$,?%#[]",
                                                                                kCFStringEncodingUTF8 ));
    
    return [NSURL URLWithString:url];

}

- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    NSString *encoded = [self urlEncode:idea];
    NSString *urlString = [@"http://ideaboardz.com/points.json?" stringByAppendingFormat:@"point[section_id]=%d&point[message]=%@", sectionId, encoded];
    
    HttpClient *client = [[HttpClient alloc] init];
    [client postTo:urlString delegate:self.parent];
    
}


-(NSURL *)urlForBoard
{
    NSString *url = [NSString stringWithFormat:@"http://www.ideaboardz.com/for/%@/%d.json",_board.boardName,_board.boardId];
    url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                          NULL,
                                                                          (CFStringRef)url,
                                                                          NULL,
                                                                          (CFStringRef)@"!*'();@&=+$,?%#[]",
                                                                          kCFStringEncodingUTF8 ));

    return [NSURL URLWithString:url];
}

- (NSString *) urlEncode:(NSString *)unencoded {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) unencoded, NULL, (CFStringRef)@"!*'();:@&=+$,/?", kCFStringEncodingUTF8));
}

@end
