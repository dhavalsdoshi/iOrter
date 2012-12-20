//
//  HttpClient.m
//  iOrter
//
//  Created by Nikita Deshmukh on 13/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "HttpClientService.h"

@interface HttpClientService ()
@property (strong, nonatomic) id delegate;
@end

@implementation HttpClientService
- (void)postTo:(NSURL *)url delegate:(id) del {
    
    self.delegate = del;
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:url];
    [postRequest setHTTPMethod:@"POST"];
    
    [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
}

- (NSData *)getFrom:(NSURL *)url
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSMutableURLRequest *httpGetRequest = [NSMutableURLRequest requestWithURL:url];
    [httpGetRequest setHTTPMethod:@"GET"];
    NSData * data = [NSURLConnection sendSynchronousRequest:httpGetRequest returningResponse:&response error:&error];
    return data;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"Recieved response for POST request : %d", [httpResponse statusCode]);
    [_delegate didProgress:25];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DidFinishLoading");
    [_delegate didProgress:100];
    [_delegate didFinish];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    NSLog(@"DidReceive Data");
    [_delegate didProgress:50];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate didFail:@""];
    NSLog(@"Did Fail With Error- %@", error.localizedDescription);
}



@end
