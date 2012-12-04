#import <Foundation/Foundation.h>
#import "SectionService.h"

@interface BoardService : NSObject
-(id) initWithSectionService:(SectionService *)sectionService;
-(NSMutableArray *) getSectionsForBoard:(NSString *)board;
@end
