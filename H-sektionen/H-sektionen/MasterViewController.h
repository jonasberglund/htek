//
//  MasterViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
