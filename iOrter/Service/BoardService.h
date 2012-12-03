#import <Foundation/Foundation.h>

@interface BoardService : NSObject
-(NSMutableArray *) getSectionsForBoard:(NSString *)board;
@end
