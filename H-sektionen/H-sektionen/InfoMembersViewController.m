//
//  InfoMembersViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-11-05.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "InfoMembersViewController.h"
#import "MenuViewController.h"

@interface InfoMembersViewController (){
    NSArray *info;
    NSArray *members;
    NSArray *links;
    NSArray *openingHours;
}

@end

@implementation InfoMembersViewController

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
        }        members = [json objectForKey:@"members"];
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
    return members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoMembersCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //MEMBERS
    NSDictionary *member = [members objectAtIndex:indexPath.row];
     NSString *name = [member objectForKey:@"name"];
     NSString *posision = [member objectForKey:@"position"];
     NSString *email = [member objectForKey:@"email"];
     NSString *phone = [member objectForKey:@"phone"];
     // NSString *description = [[event objectForKey:@"content"] objectForKey:@"$t"];
     //NSString *location = [[[event objectForKey:@"gd$where"] objectAtIndex:0] objectForKey:@"valueString"];
     // NSString *startTime = [[[pub objectForKey:@"gd$when"] objectAtIndex:0] objectForKey:@"startTime"];
     //NSString *endTime = [[[event objectForKey:@"gd$when"] objectAtIndex:0] objectForKey:@"endTime"];
     
     NSString *imgUrl = [member objectForKey:@"picture"];
     UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
     
     cell.textLabel.text = name;
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@", posision, email, phone];
     cell.imageView.image = image;
    
    //LINKS
    /*NSDictionary *link = [links objectAtIndex:indexPath.row];
     NSString *name = [link objectForKey:@"name"];
     NSString *href = [link objectForKey:@"href"];
     
     cell.textLabel.text = name;
     cell.detailTextLabel.text = href;*/
    
    
    //OPENING HOURS
    /*NSDictionary *openingHour = [openingHours objectAtIndex:indexPath.row];
    NSString *name = [openingHour objectForKey:@"name"];
    NSString *opentime = [openingHour objectForKey:@"opentime"];
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = opentime;*/
    
    return cell;
    
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

@end
