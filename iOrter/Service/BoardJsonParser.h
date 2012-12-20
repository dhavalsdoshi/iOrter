//
//  JsonParser.h
//  iOrter
//
//  Created by Nikita Deshmukh on 20/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoardJsonParser : NSObject
@property (nonatomic) NSMutableArray *array;
-(NSMutableArray *) parseToSections:(NSData *)data;
-(NSMutableArray *) parseToIdeas:(NSData *)data ofSection:(NSInteger)sectionId;

-(id)init;
@end
