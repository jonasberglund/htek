//
//  MenuViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-26.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RESideMenuDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end
