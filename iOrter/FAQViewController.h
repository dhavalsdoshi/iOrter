//
//  FAQViewController.h
//  iOrter
//
//  Created by Nikita Deshmukh on 02/01/13.
//  Copyright (c) 2013 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;
@property (nonatomic) IBOutlet UIWebView *webView;
@end
