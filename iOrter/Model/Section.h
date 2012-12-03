#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (nonatomic, strong) NSString *name;

-(id) initWithName:(NSString *)name;
@end
