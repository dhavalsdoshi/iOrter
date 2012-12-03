#import "Section.h"

@implementation Section
@synthesize name;
-(id) initWithName:(NSString *)name
{
    self = [super init];
    self.name = name;
    return self;
}
@end
