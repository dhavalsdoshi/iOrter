#import "BoardServiceTests.h"
#import <OCMock/OCMock.h>
#import <OCMock/OCMock.h>
#import <objc/objc-runtime.h>
@implementation BoardServiceTests{
    Method originalMethod;
}

-(void) testShouldGetSections
{

    id mockSectionService = [OCMockObject mockForClass: [SectionService class]];
    NSString *board = @"test/2";
    [[[mockSectionService expect] andReturn:nil] getSectionWiseIdeasForBoard:board];
    BoardService *boardService = [[BoardService alloc] initWithSectionService:mockSectionService];

    originalMethod = class_getClassMethod([NSData class], @selector(dataWithContentsOfURL:));
    Method mockMethod = class_getInstanceMethod([self class], @selector(mockMethod:));
    method_exchangeImplementations(originalMethod,mockMethod);

    NSMutableArray *sections = [boardService getSectionsForBoard:board];
    NSString *sectionName = [[sections objectAtIndex:0] name];
    NSInteger *sectionId = [[sections objectAtIndex:0] sectionId];
    STAssertTrue([sectionName isEqualToString: @"Yahya"], @"Section Name");
    STAssertEquals(sectionId, (NSInteger *)4, @"Section Id");
    method_exchangeImplementations(mockMethod, originalMethod);
}

-(NSData *) mockMethod:(NSURL *)dataURL
{
    if ([dataURL.absoluteString isEqualToString:@"http://ideaboardz.com/for/test/2.json"]) {
        NSString *d = @"{\"name\":\"test\",\"sections\":[{\"name\":\"Yahya\",\"id\":4},{\"name\":\"Didn't Go Well\",\"id\":5},{\"name\":\"Action Items\",\"id\":6}],\"id\":2,\"description\":\"Try it out\"}";
        return [d dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end
