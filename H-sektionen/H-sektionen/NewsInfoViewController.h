//
//  NewsInfoViewController.h
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-22.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsInfoViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *newsText;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
