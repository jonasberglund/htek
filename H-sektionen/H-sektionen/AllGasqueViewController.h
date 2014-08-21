//
//  AllGasqueViewController.h
//  Är det ...?
//
//  Created by Jonas Berglund on 2013-11-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllGasqueViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UITableView *gasqueTableView;
- (IBAction)dismissButton:(id)sender;

@end
