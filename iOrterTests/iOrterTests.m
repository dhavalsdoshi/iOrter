//
//  iOrterTests.m
//  iOrterTests
//
//  Created by Akshay Mankar on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "iOrterTests.h"
#import <OCMock/OCMock.h>
#import "SectionService.h"

@implementation iOrterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

-(void)testDummy
{
    id mock = [OCMockObject mockForClass:[SectionService class]];
    [[[mock stub] andReturn:@"Yahya"] getSectionsForBoard:@"Yahya"];
    STAssertEquals([mock getSectionsForBoard:@"Yahya"], @"Yahya", @"too few arguments");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
@end
