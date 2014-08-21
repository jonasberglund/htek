//
//  InfoViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-01.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "InfoViewController.h"
#import "MenuViewController.h"

@interface InfoViewController (){
    NSArray *info;
    NSArray *members;
    NSArray *links;
    NSArray *openingHours;
}

@end

@implementation InfoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadInfo];
    
}

- (void)loadInfo{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Spinner
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: @"http://www.htek.se/appen/info/index.php"]];
        
        NSError* error;
        NSDictionary *json;
        if(data != nil){
            json = [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:&error];
        }
        
        
        members = [json objectForKey:@"members"];
        links = [json objectForKey:@"links"];
        openingHours = [json objectForKey:@"openinghours"];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [spinner stopAnimating];
            [self.refreshControl endRefreshing];
            
            
        });
        
    });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return openingHours.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //OPENING HOURS
    NSDictionary *openingHour = [openingHours objectAtIndex:indexPath.row];
    NSString *name = [openingHour objectForKey:@"name"];
    NSString *opentime = [openingHour objectForKey:@"opentime"];
    
    NSArray *array = [opentime componentsSeparatedByString:@"<br/>"];
    
    NSMutableString *opentimes = [[NSMutableString alloc] init];
    
    for (int i = 0; i < array.count; i++) {
        [opentimes appendString:array[i]];
        [opentimes appendString:@"\n"];
        
    }
     cell.textLabel.text = name;
     cell.detailTextLabel.text = opentimes;

    return cell;
    
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

@end
