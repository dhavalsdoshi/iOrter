#import "Section.h"

@implementation Section
@synthesize name, sectionId, ideas;

-(id) initWithId:(NSInteger)identifier name:(NSString *)sectionName
{
    self = [super init];
    self.name = sectionName;
    self.sectionId = identifier;
    return self;
}
@end
