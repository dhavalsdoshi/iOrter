#import "Section.h"

@implementation Section
@synthesize name, sectionId, ideas;

-(id) initWithId:(NSInteger *) Id name:(NSString *)sectionName
{
    self = [super init];
    self.name = sectionName;
    self.sectionId = Id;
    return self;
}
@end
