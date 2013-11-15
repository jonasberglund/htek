//
//  EventsViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-26.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "EventsViewController.h"
#import "EventInfoViewController.h"

@interface EventsViewController (){
    NSArray *events;
}

@end

@implementation EventsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
   
    [self loadEvents];
    
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.refreshControl setTintColor:[UIColor purpleColor]];
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
                    [NSURL URLWithString: @"https://www.google.com/calendar/feeds/5id1508tk2atummuj0vq33d7lc@group.calendar.google.com/public/full?alt=json&orderby=starttime&sortorder=ascending&futureevents=true&"]];
    
    
        NSError* error;
        NSDictionary *json;
        if(data != nil){
            json = [NSJSONSerialization JSONObjectWithData:data
                                                   options:kNilOptions
                                                     error:&error];
        }
    
        events = [[json objectForKey:@"feed"] objectForKey:@"entry"];
       
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [spinner stopAnimating];
            [self.refreshControl endRefreshing];
            
            
        });

    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *event = [events objectAtIndex:indexPath.row];
    NSString *title = [[event objectForKey:@"title"] objectForKey:@"$t"];
   // NSString *description = [[event objectForKey:@"content"] objectForKey:@"$t"];
    //NSString *location = [[[event objectForKey:@"gd$where"] objectAtIndex:0] objectForKey:@"valueString"];
    NSString *startTime = [[[event objectForKey:@"gd$when"] objectAtIndex:0] objectForKey:@"startTime"];
    //NSString *endTime = [[[event objectForKey:@"gd$when"] objectAtIndex:0] objectForKey:@"endTime"];
    
    NSString *in_time = [self toDate:startTime];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", in_time];
    
    return cell;
    
}

- (NSString *)toDate:(NSString *)time {
    
    NSCalendar *now = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSArray *date = [time componentsSeparatedByString:@"T"];
    NSArray *dates = [time componentsSeparatedByString:@"-"];
    
    NSInteger year = [dates[0] integerValue];
    NSInteger month = [dates[1] integerValue];
    NSInteger day = [dates[2] integerValue];
    
    NSDateComponents *components = [now components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger days = day - [components day];
    NSInteger months = month - [components month];
    NSInteger years = year - [components year];
    
    NSMutableString *clock = [NSMutableString stringWithString: @""];
    if(time.length > @"1967-09-03".length){
        NSString *clock_temp = [NSString stringWithFormat:@"kl: %@", [date[1] substringWithRange:NSMakeRange(0, 5)]];
        [clock setString:clock_temp];
    }
    
    
    if(years == 1)
        return @"Nästa år";
    else if (years > 1)
        return [NSString stringWithFormat:@"Om %li år", (long)years];
    else if (months == 1)
        return @"Nästa månad";
    else if (months > 1)
        return [NSString stringWithFormat:@"Om %li månader", (long)months];
    else if (days == 1)
        return [NSString stringWithFormat:@"I morgon %@", clock];
    else if (days > 1)
        return [NSString stringWithFormat:@"Om %li dagar", (long)days];
    
    return [NSString stringWithFormat:@"Idag %@", clock];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEvent"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *event = [events objectAtIndex:row];
        
        EventInfoViewController *eventController = segue.destinationViewController;
        eventController.detailItem = event;
    }
}

- (void) reloadData{
    [self loadEvents];
    [self.eventsTableView reloadData];
    
    [self.refreshControl endRefreshing];
   
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

@end
