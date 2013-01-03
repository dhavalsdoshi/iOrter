#import "Idea.h"

@implementation Idea

-(id)initWithId:(NSInteger)identifier andMessage:(NSString *)message
{
    if(self = [super init])
    {
        _message = message;
        _ideaId = identifier;
    }
    return self;
}

@end
