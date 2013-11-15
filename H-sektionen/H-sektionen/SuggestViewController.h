//
//  SuggestViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-01.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SuggestViewController : UIViewController <MFMailComposeViewControllerDelegate>
-(IBAction)showMenu;
- (IBAction)showEmail:(id)sender;

@end
