#import "BoardServiceTests.h"
#import "Section.h"
#import <objc/objc-runtime.h>
@implementation BoardServiceTests

-(void) testShouldGetSections
{
    BoardService *sectionService = [[BoardService alloc] init];
    
    Method originalMethod = class_getClassMethod([NSData class], @selector(dataWithContentsOfURL:));
    Method mockMethod = class_getInstanceMethod([self class], @selector(mockMethod:));
    method_exchangeImplementations(originalMethod,mockMethod);
    NSMutableArray *sections = [sectionService getSectionsForBoard:@"fdskfhjkls"];
    NSString *str = [[sections objectAtIndex:0] name];
    STAssertTrue([str isEqualToString: @"Yahya"], @"Getting Sections from Section Service");
    method_exchangeImplementations(mockMethod, originalMethod);
}

-(NSData *) mockMethod:(NSURL *)dataURL
{
    NSString *d = @"{\"name\":\"test\",\"sections\":[{\"name\":\"Yahya\",\"id\":4},{\"name\":\"Didn't Go Well\",\"id\":5},{\"name\":\"Action Items\",\"id\":6}],\"id\":2,\"description\":\"Try it out\"}";
    return [d dataUsingEncoding:NSUTF8StringEncoding];
}
@end
