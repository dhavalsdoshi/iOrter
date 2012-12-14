//
//  main.m
//  iOrter
//
//  Created by Akshay Mankar on 29/11/12.
//  Copyright (c) 2012 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        @try {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch(NSException * e) {
            NSLog(@"%@", e.callStackSymbols);
        }
        
    }
}
