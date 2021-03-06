#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger sectionId;
@property(nonatomic, strong) NSMutableArray *ideas;

-(id) initWithId:(NSInteger)identifier name:(NSString *)sectionName;
@end
