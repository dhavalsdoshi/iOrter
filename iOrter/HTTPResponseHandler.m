//
//  HTTPResponseHandler.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "HTTPResponseHandler.h"

@interface HTTPResponseHandler()

@property (strong, nonatomic) Complete completeCallback;
@property (strong, nonatomic) Progress progressStatus;
@end

@implementation HTTPResponseHandler

-(id) initWithCompletion:(Complete)complete andProgress:(Progress)progress{
    self = [super init];
    if (self) {
        self.completeCallback = complete;
        self.progressStatus = progress;
        
    }
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Recieved response for POST request : %d", [httpResponse statusCode]);
    self.progressStatus(25);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DidFinishLoading");
    self.progressStatus(100);
    self.completeCallback();
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"DidReceive Data");
    self.progressStatus(50);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Did Fail With Error- %@", error.localizedDescription);
}

@end
