#import "SectionService.h"
#import "Section.h"
#import "HTTPResponseHandler.h"
#import "MBProgressHUD.h"


@implementation SectionService

-(id) initWithView:(UIView *)v {
    self = [super init];
    if (self) {
        self.view = v;
    }
    return self;
}

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

- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId
{
    NSString *encoded = [self urlEncode:idea];
    NSString *urlString = [@"http://ideaboardz.com/points.json?" stringByAppendingFormat:@"point[section_id]=%d&point[message]=%@",sectionId, encoded];

    NSURL *ideaUrl = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:ideaUrl];
    [postRequest setHTTPMethod:@"POST"];
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Posting";
    
    [self httpCall:postRequest withProgress:^(float progress) {
        hud.progress = progress;
    } withCompletion:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void) httpCall:(NSMutableURLRequest *)postRequest withProgress:(Progress)progress withCompletion:(Complete)complete {
    HTTPResponseHandler *handler = [[HTTPResponseHandler alloc] initWithCompletion:complete];
    [[NSURLConnection alloc] initWithRequest:postRequest delegate:handler];
}

- (NSString *) urlEncode:(NSString *)unencoded {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) unencoded, NULL, (CFStringRef)@"!*'();:@&=+$,/?", kCFStringEncodingUTF8));
}
@end
