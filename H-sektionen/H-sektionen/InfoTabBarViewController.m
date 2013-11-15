//
//  InfoTabBarViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-08.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "InfoTabBarViewController.h"
#import "MenuViewController.h"

@interface InfoTabBarViewController ()

@end

@implementation InfoTabBarViewController

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

@end
