  #import "SectionServiceTest.h"
#import "Section.h"
#import "SectionService.h"
#import <objc/objc-runtime.h>
#import "OCMock/OCmock.h"
@implementation SectionServiceTest
-(void) testShouldGetIdeas
{
    SectionService *sectionService = [[SectionService alloc] init];

    Method originalMethod = class_getClassMethod([NSData class], @selector(dataWithContentsOfURL:));
    Method mockMethod = class_getInstanceMethod([self class], @selector(mockMethod:));
    method_exchangeImplementations(originalMethod,mockMethod);
    NSDictionary *dictionary = [sectionService getSectionWiseIdeasForBoard:@"test/board"];
    NSMutableArray *section1Ideas = [dictionary objectForKey:[NSNumber numberWithChar:1]];
    STAssertTrue([section1Ideas containsObject:@"Idea 1"], @"");
    method_exchangeImplementations(mockMethod, originalMethod);
}

-(NSData *) mockMethod:(NSURL *)dataURL
{
    if ([[dataURL absoluteString] isEqualToString:@"http://ideaboardz.com/retros/test/board/points.json"]) {
        NSString *d = @"[{\"created_at\":\"2012/11/28 08:22:10 +0000\",\"updated_at\":\"2012/11/30 05:58:28 +0000\",\"section_id\":1,\"id\":114740,\"message\":\"Idea 1\",\"votes_count\":1},{\"created_at\":\"2012/11/28 08:22:17 +0000\",\"updated_at\":\"2012/11/30 16:09:47 +0000\",\"section_id\":2,\"id\":114741,\"message\":\"Idea 2\",\"votes_count\":1},{\"created_at\":\"2012/11/28 09:40:58 +0000\",\"updated_at\":\"2012/11/30 23:09:28 +0000\",\"section_id\":2,\"id\":114774,\"message\":\"Idea 3\",\"votes_count\":4},{\"created_at\":\"2012/12/03 10:28:24 +0000\",\"updated_at\":\"2012/12/03 10:28:24 +0000\",\"section_id\":3,\"id\":115845,\"message\":\"Idea 4\",\"votes_count\":2},{\"created_at\":\"2012/12/03 10:28:29 +0000\",\"updated_at\":\"2012/12/03 10:28:29 +0000\",\"section_id\":3,\"id\":115846,\"message\":\"Idea 5\",\"votes_count\":1},{\"created_at\":\"2012/11/28 08:22:48 +0000\",\"updated_at\":\"2012/11/28 13:20:54 +0000\",\"section_id\":1,\"id\":114744,\"message\":\"Idea 6\",\"votes_count\":2}]";
        return [d dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}


-(void) testShouldAddANewIdeaToGivenSection {
//TODO
}

@end
