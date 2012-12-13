//
//  HTTPResponseHandler.h
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^Progress)(float);
typedef void (^Complete)(void);

@interface HTTPResponseHandler : NSObject <NSURLConnectionDelegate>

-(id) initWithCompletion:(Complete)complete andProgress:(Progress)progress;
@end
