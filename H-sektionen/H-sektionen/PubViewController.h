//
//  PubViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-30.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubViewController : UITableViewController
- (IBAction)showMenu;
@property (strong, nonatomic) IBOutlet UITableView *pubsTableView;

@end
