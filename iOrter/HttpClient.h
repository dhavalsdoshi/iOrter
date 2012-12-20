//
//  HttpClient.h
//  iOrter
//
//  Created by Nikita Deshmukh on 13/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HttpTaskDelegate
-(void)didProgress:(float)progress;
-(void)didFinish;
-(void)didFail:(NSString *)data;

@end

@interface HttpClient : NSObject <NSURLConnectionDelegate>
- (void)postTo:(NSURL *)urlString delegate:(id) del;
- (NSData *)getDataFrom:(NSURL *)url;
@end
