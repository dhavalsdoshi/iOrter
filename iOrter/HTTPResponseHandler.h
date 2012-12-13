//
//  HTTPResponseHandler.h
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"


@interface HTTPResponseHandler : NSObject <NSURLConnectionDelegate>

-(id) initWithCompletion:(onComplete)complete andProgress:(onProgress)progress;
@end
