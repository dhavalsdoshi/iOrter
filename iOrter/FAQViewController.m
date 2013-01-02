//
//  FAQViewController.m
//  iOrter
//
//  Created by Nikita Deshmukh on 02/01/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ideaboardz.com/page/faq"]];
    
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    [_loader stopAnimating];
    _loader.hidden = YES;
}
- (void)viewDidUnload {
    [self setLoader:nil];
    [super viewDidUnload];
}
@end
