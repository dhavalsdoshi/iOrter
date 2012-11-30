//
//  Section.h
//  iOrter
//
//  Created by Yahya Poonawala on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (nonatomic, strong) NSString *name;

-(id) initWithName:(NSString *)name;
@end
