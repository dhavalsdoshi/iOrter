//
//  HTTPResponseHandler.m
//  iOrter
//
//  Created by Nikita Deshmukh on 11/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "HTTPResponseHandler.h"

@implementation HTTPResponseHandler

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Recieved response for POST request : %d", [httpResponse statusCode]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DidFinishLoading");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"DidReceive Data");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Did Fail With Error");
}

@end
