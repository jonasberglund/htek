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
   
}

- (void)loadEvents{
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: @"https://www.google.com/calendar/feeds/5id1508tk2atummuj0vq33d7lc@group.calendar.google.com/public/full?alt=json&orderby=starttime&sortorder=ascending&futureevents=true&"]];
    
    
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&error];
    
    events = [[json objectForKey:@"feed"] objectForKey:@"entry"];
    

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
    
    NSDictionary *evnet = [events objectAtIndex:indexPath.row];
    NSString *title = [[evnet objectForKey:@"title"] objectForKey:@"$t"];
    NSString *description = [[evnet objectForKey:@"content"] objectForKey:@"$t"];
    //NSString *time = [[[evnet objectForKey:@"gd$when"] objectForKey:0] objectForKey:@"startTime"];
    //NSString *where = [[[evnet objectForKey:@"gd$where"] objectForKey:0] objectForKey:@"valueString"];
    
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", description];
    
    return cell;
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
