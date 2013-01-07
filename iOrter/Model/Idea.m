#import "Idea.h"

@implementation Idea

-(id)initWithId:(NSInteger)identifier Message:(NSString *)message andVotes:(NSInteger)votes_count
{
    if(self = [super init])
    {
        _message = message;
        _ideaId = identifier;
        _votesCount = votes_count;
    }
    return self;
}

@end
