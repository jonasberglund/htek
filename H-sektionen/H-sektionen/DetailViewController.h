//
//  DetailViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
