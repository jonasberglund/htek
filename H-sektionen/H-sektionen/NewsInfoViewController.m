//
//  NewsInfoViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-22.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "NewsInfoViewController.h"

@interface NewsInfoViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;

@end

@implementation NewsInfoViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *newsItem = self.detailItem;
        
        NSString *title = [newsItem objectForKey:@"message"];
        NSString *time = [newsItem objectForKey:@"created_time"];
        NSArray *date = [time componentsSeparatedByString:@"T"];
        //NSString *time = [[[evnet objectForKey:@"gd$when"] objectForKey:0] objectForKey:@"startTime"];
        //NSString *where = [[[evnet objectForKey:@"gd$where"] objectForKey:0] objectForKey:@"valueString"];
        
        //json_arr.getJSONObject(i).optString("picture");
        
        NSString *imgUrl = [newsItem objectForKey:@"picture"];
        if(!(imgUrl == nil)){
         NSMutableString *img = [imgUrl mutableCopy];
         
         [img replaceOccurrencesOfString:@"s.jpg" withString:@"n.jpg" options:NSLiteralSearch range:NSMakeRange(0, img.length)];
         imgUrl = img;
         }
        
         UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];

        _imageView.image = image;
        _detailDescriptionLabel.text = date[0];
        _newsText.text = title;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
