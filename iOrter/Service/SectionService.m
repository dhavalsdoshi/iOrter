#import "SectionService.h"
#import "Section.h"
#import "MBProgressHUD.h"
#import "HttpClient.h"


@implementation SectionService

-(id) initWithParent:(id)par {
    self = [super init];
    if (self) {
        self.parent = par;
    }
    return self;
}

- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board {
    NSMutableString *URLString = [NSMutableString stringWithString: @"http://ideaboardz.com/retros"];
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

- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId 
{
    NSString *encoded = [self urlEncode:idea];
    NSString *urlString = [@"http://ideaboardz.com/points.json?" stringByAppendingFormat:@"point[section_id]=%d&point[message]=%@", sectionId, encoded];

    HttpClient *client = [[HttpClient alloc] init];
    [client postTo:urlString delegate:self.parent];
    
}
- (NSString *) urlEncode:(NSString *)unencoded {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) unencoded, NULL, (CFStringRef)@"!*'();:@&=+$,/?", kCFStringEncodingUTF8));
}
@end
