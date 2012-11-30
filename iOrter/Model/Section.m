//
//  Section.m
//  iOrter
//
//  Created by Yahya Poonawala on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

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
