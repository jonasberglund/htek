//
//  WebViewController.m
//  Är det ...?
//
//  Created by Jonas Berglund on 2013-11-24.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
        NSString *url = @"http://gasquen.se";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    
         dispatch_async(dispatch_get_main_queue(), ^{
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
    });
    
});


}



- (IBAction)dismissButton:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
