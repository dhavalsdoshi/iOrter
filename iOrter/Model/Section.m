#import "Section.h"

@implementation Section
@synthesize name, sectionId, ideas;

-(id) initWithId:(NSInteger *) sectionId name:(NSString *)sectionName
{
    self = [super init];
    self.name = sectionName;
    self.sectionId = sectionId;
    return self;
}
@end
