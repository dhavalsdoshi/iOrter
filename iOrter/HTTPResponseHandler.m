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
@end

@implementation HTTPResponseHandler

-(id) initWithCompletion:(Complete) complete {
    self = [super init];
    if (self) {
        self.completeCallback = complete;
    }
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Recieved response for POST request : %d", [httpResponse statusCode]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DidFinishLoading");
    self.completeCallback();
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"DidReceive Data");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Did Fail With Error- %@", error.localizedDescription);
}

@end
