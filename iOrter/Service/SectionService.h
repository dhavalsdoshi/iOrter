
#import <Foundation/Foundation.h>
#import "Section.h"
#import "Board.h"

@interface SectionService : NSObject

@property (nonatomic, strong) id parent;

-(id)initWithParent:(id)parent;
- (NSDictionary *)getSectionWiseIdeasForBoard:(NSString *)board;
- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId ;
-(NSMutableArray *)getIdeasForSection:(NSInteger)sectionId;
-(id)initWithBoard:(Board *)boardObject;
@end
