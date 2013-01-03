#import <Foundation/Foundation.h>

@interface Idea : NSObject
@property(nonatomic, strong) NSString *message;
@property(nonatomic) NSInteger ideaId;
-(id)initWithId:(NSInteger)identifier andMessage:(NSString *)message;

@end
