
#import <Foundation/Foundation.h>
#import "Section.h"

@interface SectionService : NSObject

- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board;
- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId;
@end
