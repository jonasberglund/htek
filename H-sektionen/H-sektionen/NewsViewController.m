//
//  NewsViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-26.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController (){
    NSArray *news;
}

@end

@implementation NewsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadEvents];
    
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    
    
    
}

- (void)loadEvents{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Spinner
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: @"http://www.prokrastinera.com/hsektionen/newsfeed/?week=0"]];
    
    
        NSError* error;
    
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    
        news = [json objectForKey:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [spinner stopAnimating];
            [self.refreshControl endRefreshing];
            
        });
    
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *newsItem = [news objectAtIndex:indexPath.row];
    NSString *title = [newsItem objectForKey:@"message"];
    NSString *time = [newsItem objectForKey:@"created_time"];
    NSArray *date = [time componentsSeparatedByString:@"T"];
    //NSString *time = [[[evnet objectForKey:@"gd$when"] objectForKey:0] objectForKey:@"startTime"];
    //NSString *where = [[[evnet objectForKey:@"gd$where"] objectForKey:0] objectForKey:@"valueString"];
    
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", date[0]];
    
    return cell;
}

- (void) reloadData{
    [self loadEvents];
    [self.newsTableView reloadData];
}


- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

@end
