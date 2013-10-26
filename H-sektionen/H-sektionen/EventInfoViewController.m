//
//  EventInfoViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-27.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "EventInfoViewController.h"

@interface EventInfoViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

@implementation EventInfoViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *event = self.detailItem;
        
        NSString *title = [[event objectForKey:@"title"] objectForKey:@"$t"];
        NSString *description = [[event objectForKey:@"content"] objectForKey:@"$t"];
        
        _detailDescriptionLabel.text = description;
        _titleLabel.text = title;
     
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
