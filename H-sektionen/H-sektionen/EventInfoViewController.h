//
//  EventInfoViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-27.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventInfoViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end
