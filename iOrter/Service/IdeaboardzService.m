#import "IdeaboardzService.h"
#import "Section.h"
#import "HttpClient.h"
#import "Board.h"

@interface IdeaboardzService()

@end

@implementation IdeaboardzService{
}

-(id) initWithBoard:(Board *)boardObject{
    self = [super init];
    self.board = boardObject;
    _parser = [[BoardJsonParser alloc] init];
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
    NSString *encodedBoardName = [self encode:_board.boardName];
    
    NSString *boardUrl = [NSString stringWithFormat:@"http://www.ideaboardz.com/for/%@/%d.json",encodedBoardName,_board.boardId];
    
    NSURL *url = [NSURL URLWithString:boardUrl];
    
    HttpClient *client = [[HttpClient alloc] init];
    NSData *boardJson = [client getDataFrom:url];
    
    NSMutableArray *sections = [_parser parseJsonForSections:boardJson];
    
    return sections;
}

-(NSMutableArray *) getIdeasForSection:(NSInteger)sectionId{
   
    NSString *encodedBoardName = [self encode:_board.boardName];

    NSString *unencodedUrlForIdeas = [NSString stringWithFormat:@"http://www.ideaboardz.com/retros/%@/%d/points.json",encodedBoardName,_board.boardId];
    
    NSURL *ideaUrl = [NSURL URLWithString:unencodedUrlForIdeas];
    
    HttpClient *client = [[HttpClient alloc] init];
    NSData *jsonIdeas = [client getDataFrom:ideaUrl];
    
    NSMutableArray *ideas = [_parser parseJsonForIdeas:jsonIdeas ofSection:sectionId];
    return ideas;
    
    
}
//Request URL:http://ideaboardz.com/retros/test/2/points.json


- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    
    NSString *encodedIdea = [self encode:idea];
    NSString *urlString = [@"http://ideaboardz.com/points.json?" stringByAppendingFormat:@"point[section_id]=%d&point[message]=%@", sectionId, encodedIdea];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    HttpClient *client = [[HttpClient alloc] init];
    
    [client postTo:url delegate:self.parent];
    
}

- (NSString *) encode:(NSString *)unencoded {
     return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) unencoded, NULL, (CFStringRef)@"!*'();@&=+$,?:/", kCFStringEncodingUTF8));

}

@end
