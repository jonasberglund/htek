//
//  NewsViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-26.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface NewsViewController : UITableViewController

- (IBAction)showMenu;
@property (strong, nonatomic) IBOutlet UITableView *newsTableView;

@end
