
#import <Foundation/Foundation.h>
#import "Section.h"

@interface SectionService : NSObject

@property (nonatomic, strong) UIView *view;

-(id)initWithView:(UIView *)view;
- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board;
- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId;
@end
