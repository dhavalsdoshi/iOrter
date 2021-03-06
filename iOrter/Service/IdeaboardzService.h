#import <Foundation/Foundation.h>
#import "Board.h"
#import "BoardJsonParser.h"

@interface IdeaboardzService : NSObject
@property (nonatomic,strong) Board *board;
@property (nonatomic,strong) id parent;
@property (nonatomic) BoardJsonParser *JsonParser;

-(id) initWithBoard:(Board *)board parent:(id)parent;
-(id) initWithParent:(id)parent;

-(NSMutableArray *) getSections;
-(NSMutableArray *) getIdeasForSection:(NSInteger)sectionId;
- (void)addIdea:(NSString *)idea toSection:(NSInteger)sectionId;
-(void)deleteIdeaWithId:(NSInteger)ideaId;
-(void)editIdeaWithId:(NSInteger)ideaId message:(NSString *)message;
-(void)voteForIdeaWithId:(NSInteger)ideaId;

@end
