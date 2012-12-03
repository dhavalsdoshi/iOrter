#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger *sectionId;
-(id) initWithId:(NSInteger *) sectionId name:(NSString *)sectionName;
@end
