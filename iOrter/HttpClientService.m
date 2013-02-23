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

@implementation HttpClientService{
    NSMutableURLRequest *request;
}

- (void)postTo:(NSURL *)url delegate:(id) del {
    
    self.delegate = del;
    
    request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSData *)getFrom:(NSURL *)url
{
    NSHTTPURLResponse *response = nil;
    NSError *error;
    request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error.code == NSURLErrorNotConnectedToInternet){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    return data;
}

-(void)putTo:(NSURL *)url delegate:(id)del
{
    self.delegate = del;
    request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"PUT"];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    if (error.code == NSURLErrorNotConnectedToInternet){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    [_delegate didFail:@""];
    NSLog(@"Did Fail With Error- %@", error.localizedDescription);
}



@end
