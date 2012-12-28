//
//  Board.h
//  iOrter
//
//  Created by Nikita Deshmukh on 19/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Section.h"
@interface Board : NSObject

@property (nonatomic, strong) NSString *boardName;
@property (nonatomic) NSInteger boardId;
@property (nonatomic,strong) NSMutableArray *sections;
@property (nonatomic , strong) NSString *url;

-(id)initWithId:(NSInteger)boardId name:(NSString *)boardName;
-(id)initWithUrl:(NSString *)url;
@end
