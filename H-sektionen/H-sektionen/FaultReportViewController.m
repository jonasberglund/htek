//
//  FaultReportViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-01.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "FaultReportViewController.h"
#import "MenuViewController.h"

@interface FaultReportViewController ()

@end

@implementation FaultReportViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

- (IBAction)showEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Felanmälan";
    // Email Content
    NSString *messageBody = @"Det här är trasigt: \n\n Var: \n\n\n ---------------\nDen här felanmälan är skickat från H-sektionsappen";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"8800@chalmers.se"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (IBAction)showComputerEmail:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Felanmälan";
    // Email Content
    NSString *messageBody = @"Det här är trasigt: \n\n Var: \n\n\n ---------------\nDen här felanmälan är skickat från H-sektionsappen";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@chalmers.se"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
