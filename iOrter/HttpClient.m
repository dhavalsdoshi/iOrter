//
//  HttpClient.m
//  iOrter
//
//  Created by Nikita Deshmukh on 13/12/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import "HttpClient.h"

@interface HttpClient ()
@property (strong, nonatomic) id delegate;
@end

@implementation HttpClient
- (void)postTo:(NSString *)urlString delegate:(id) del {
    self.delegate = del;
    
    NSURL *ideaUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:ideaUrl];
    [postRequest setHTTPMethod:@"POST"];
    
    [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
//    [self httpCall:postRequest withProgress:progress withCompletion:complete];
}
- (NSData *)getSectionsFromBoard:(NSURL *)boardJSONURL
{
    NSData *boardJSONString = [NSData dataWithContentsOfURL:boardJSONURL];
    return boardJSONString;
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
