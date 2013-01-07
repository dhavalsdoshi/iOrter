#import <Foundation/Foundation.h>

@interface Idea : NSObject
@property(nonatomic, strong) NSString *message;
@property(nonatomic) NSInteger ideaId;
@property(nonatomic) NSInteger votesCount;
-(id)initWithId:(NSInteger)identifier Message:(NSString *)message andVotes:(NSInteger)votes_count;

@end
