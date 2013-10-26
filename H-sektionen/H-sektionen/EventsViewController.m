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
}

- (void)loadEvents{
    
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: @"https://www.google.com/calendar/feeds/5id1508tk2atummuj0vq33d7lc@group.calendar.google.com/public/full?alt=json&orderby=starttime&sortorder=ascending&futureevents=true&"]];
    
    
    NSError* error;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&error];
    
    events = [[json objectForKey:@"feed"] objectForKey:@"entry"];
    
    
    /*
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSData* data = [NSData dataWithContentsOfURL:
     [NSURL URLWithString: @"https://api.twitter.com/1/statuses/public_timeline.json"]];
     
     NSError* error;
     
     tweets = [NSJSONSerialization JSONObjectWithData:data
     options:kNilOptions
     error:&error];
     
     dispatch_async(dispatch_get_main_queue(), ^{
     [self.tableView reloadData];
     });
     });
     
     */
    
    /*
     String data = getJSON(Constants.GOOGLEEVENTS);
     
     JSONObject json_obj = new JSONObject(data).getJSONObject("feed");
     JSONArray json_arr = json_obj.getJSONArray("entry");
     
     List<Event> events = new ArrayList<Event>();
     
     //Collection the right content from JSON
     for (int i = 0; i < json_arr.length(); i++){
     String fullDate;
     String title = json_arr.getJSONObject(i).getJSONObject("title").optString("$t");
     String description =   json_arr.getJSONObject(i).getJSONObject("content").optString("$t");
     String time =          json_arr.getJSONObject(i).getJSONArray("gd$when").getJSONObject(0).optString("startTime");
     String endTime = json_arr.getJSONObject(i).getJSONArray("gd$when").getJSONObject(0).optString("endTime");
     String where = json_arr.getJSONObject(i).getJSONArray("gd$where").getJSONObject(0).optString("valueString");
     
     fullDate = formDate(time, endTime);
     time = toDate(time);
     
     //Add events if it has i title
     if (!title.equals("")){
     events.add(new Event(title, description, where, time + ". ", fullDate));
     }
     }
     return events;
     */
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

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

@end
