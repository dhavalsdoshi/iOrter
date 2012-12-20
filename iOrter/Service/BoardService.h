#import <Foundation/Foundation.h>
#import "Board.h"

@interface BoardService : NSObject
@property (nonatomic,strong) Board *board;
@property (nonatomic,strong) id parent;
-(id) initWithBoard:(Board *)boardObject;
-(id) initWithParent:(id)parent;

-(NSMutableArray *) getSections;
-(NSMutableArray *) getIdeasForSection:(NSInteger)sectionId;
- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId;

@end
