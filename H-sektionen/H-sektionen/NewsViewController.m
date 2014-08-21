//
//  NewsViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-26.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsInfoViewController.h"

@interface NewsViewController (){
    NSMutableArray *news;
}

@end

@implementation NewsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadNews];
    
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.refreshControl setTintColor:[UIColor purpleColor]];
    
}

- (void)loadNews{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Spinner
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: [NSString stringWithFormat:@"http://www.htek.se/appen/newsfeed/?week=%d", 0]]];
    
        NSError* error;
        NSDictionary *json;
        if(data != nil){
            json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
        }
    

        
        news = [[json objectForKey:@"data"] mutableCopy];
        
        //Remove entrys that are'nt news (e.g comments)
        for (int i=0; i < news.count; i++) {
            
            if([[news objectAtIndex:i] objectForKey:@"message"] == nil){
                [news removeObjectAtIndex:i];
                i--;
            }
        
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [spinner stopAnimating];
            [self.refreshControl endRefreshing];
            
            if(data == nil){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Felmeddelande" message:@"Kontrollera din interwebsanslutning" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
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
    
    //json_arr.getJSONObject(i).optString("picture");
  
    NSString *imgUrl = [newsItem objectForKey:@"picture"];
   /* if(!(imgUrl == nil)){
        NSMutableString *img = [imgUrl mutableCopy];
        
        [img replaceOccurrencesOfString:@"s.jpg" withString:@"n.jpg" options:NSLiteralSearch range:NSMakeRange(0, img.length)];
        imgUrl = img;
    }*/


    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
       
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
  
            [[cell imageView] setImage:image];
            //cell.imageView.image = image;
            [cell setNeedsLayout];
      

        });
    });
    
    if(title != nil){
        cell.textLabel.text = title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", date[0]];
    }
    else  {
        cell.hidden = true;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNews"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *newsItem = [news objectAtIndex:row];
        
        NewsInfoViewController *newsController = segue.destinationViewController;
        newsController.detailItem = newsItem;
    }
}


- (void) reloadData{
    [self loadNews];
    [self.newsTableView reloadData];
}



- (IBAction)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}
@end
