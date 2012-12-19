//
//  Board.m
//  iOrter
//
//  Created by Nikita Deshmukh on 19/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "Board.h"

@implementation Board
-(id)initWithId:(NSInteger)boardId name:(NSString *)boardName{
    if(self = [super init]){
        self.boardName = boardName;
        self.boardId = boardId;
    }
    return self;
}
@end
