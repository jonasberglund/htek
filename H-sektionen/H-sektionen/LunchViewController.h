//
//  LunchViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-31.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchViewController : UITableViewController <NSXMLParserDelegate>
- (IBAction)showMenu;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *lunchTableView;
@property (strong, nonatomic) IBOutlet UILabel *todayLabel;


@end
