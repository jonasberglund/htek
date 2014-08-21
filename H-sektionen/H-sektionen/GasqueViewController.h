//
//  ViewController.h
//  Är det ...?
//
//  Created by Jonas Berglund on 2013-11-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GasqueViewController : UIViewController <NSXMLParserDelegate>
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UILabel *isItTodayLabel;

@property (strong, nonatomic) IBOutlet UITextView *descToday;
@property (strong, nonatomic) IBOutlet UILabel *isItTomorrowLabel;
@property (strong, nonatomic) IBOutlet UITextView *descTomorrow;

- (IBAction)showMenu;

@end
