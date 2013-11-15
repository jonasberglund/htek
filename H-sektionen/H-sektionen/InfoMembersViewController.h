//
//  InfoMembersViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-05.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoMembersViewController : UITableViewController
- (IBAction)showMenu;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *infoMembersTableView;

@end
