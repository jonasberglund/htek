//
//  WebViewController.h
//  Är det ...?
//
//  Created by Jonas Berglund on 2013-11-24.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)dismissButton:(id)sender;

@end
