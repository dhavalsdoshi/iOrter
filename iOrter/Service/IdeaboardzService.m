#import "IdeaboardzService.h"
#import "Section.h"
#import "HttpClientService.h"
#import "Board.h"

@interface IdeaboardzService()

@end

@implementation IdeaboardzService{
}

-(id) initWithBoard:(Board *)boardObject{
    self = [super init];
    self.board = boardObject;
    _JsonParser = [[BoardJsonParser alloc] init];
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
    NSString *boardUrl;
    NSString *encodedBoardName = [self encode:_board.boardName];
    if (_board.url == nil) {
        boardUrl = [NSString stringWithFormat:@"http://www.ideaboardz.com/for/%@/%d.json",encodedBoardName,_board.boardId];
    
    }
    else{
        boardUrl = [NSString stringWithFormat:@"http://www.ideaboardz.com%@.json",_board.url];
    }
    
    NSURL *url = [NSURL URLWithString:boardUrl];
    
    HttpClientService *client = [[HttpClientService alloc] init];
    NSData *boardJson = [client getFrom:url];
    
    NSMutableArray *sections = [_JsonParser parseToSections:boardJson];
    
    return sections;
}

-(NSMutableArray *) getIdeasForSection:(NSInteger)sectionId{
    NSString *unencodedUrlForIdeas;
    NSString *encodedBoardName = [self encode:_board.boardName];
    if (_board.url == nil) {
    unencodedUrlForIdeas = [NSString stringWithFormat:@"http://www.ideaboardz.com/retros/%@/%d/points.json",encodedBoardName,_board.boardId];
        
    }
    else{
        NSString *urlPath = [_board.url stringByReplacingOccurrencesOfString:@"/for/" withString:@"/retros/"];
        unencodedUrlForIdeas = [NSString stringWithFormat:@"http://www.ideaboardz.com%@/points.json",urlPath];
        
    }
    
    NSURL *ideaUrl = [NSURL URLWithString:unencodedUrlForIdeas];
    
    HttpClientService *client = [[HttpClientService alloc] init];
    NSData *jsonIdeas = [client getFrom:ideaUrl];
    
    NSMutableArray *ideas = [_JsonParser parseToIdeas:jsonIdeas ofSection:sectionId];
    return ideas;
    
    
}
//Request URL:http://ideaboardz.com/retros/test/2/points.json


- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    
    NSString *encodedIdea = [self encode:idea];
    NSString *urlString = [@"http://ideaboardz.com/points.json?" stringByAppendingFormat:@"point[section_id]=%d&point[message]=%@", sectionId, encodedIdea];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    HttpClientService *client = [[HttpClientService alloc] init];
    
    [client postTo:url delegate:self.parent];
    
}

-(void)deleteIdeaWithId:(NSInteger)ideaId
{
    NSString *urlString = [@"http://www.ideaboardz.com/points/delete/" stringByAppendingFormat:@"%d.json",ideaId ];
    NSURL *url = [NSURL URLWithString:urlString];
    HttpClientService *client = [[HttpClientService alloc]init];
    NSData *data = [client getFrom:url];

}

-(void)editIdeaWithId:(NSInteger)ideaId message:(NSString *)message
{
    NSString *encodedIdea = [self encode:message];
    
    NSString *urlString = [@"http://ideaboardz.com/points" stringByAppendingFormat:@"/%d?point[message]=%@",ideaId,encodedIdea];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    HttpClientService *client = [[HttpClientService alloc] init];
    
    [client putTo:url delegate:self.parent];
}
- (NSString *) encode:(NSString *)unencoded {
     return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) unencoded, NULL, (CFStringRef)@"!*'();@&=+$,?:/", kCFStringEncodingUTF8));

}

@end
