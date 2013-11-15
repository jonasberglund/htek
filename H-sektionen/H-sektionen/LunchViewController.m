//
//  LunchViewController.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-31.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "LunchViewController.h"
#import "MenuViewController.h"

@interface LunchViewController (){
    NSArray *lunches;
    NSXMLParser *parser;
    NSXMLParser *parserKokboken;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSString *element;
    NSString *currentTime;
}

@end

@implementation LunchViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentTime = [dateFormatter stringFromDate:[NSDate date]];
    self.todayLabel.text = currentTime;
    [self loadLunch];
    
}

- (void)loadLunch{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Spinner
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
    
        
        
        feeds = [[NSMutableArray alloc] init];
        
        
        
        
        //Kokboken
        NSURL *kokbokenURL = [NSURL URLWithString: [NSString stringWithFormat:@"http://cm.lskitchen.se/lindholmen/kokboken/sv/%@.rss", currentTime]];
        parserKokboken = [[NSXMLParser alloc] initWithContentsOfURL:kokbokenURL];
        
        [parserKokboken setDelegate:self];
        [parserKokboken setShouldResolveExternalEntities:NO];
        [parserKokboken parse];
        
        
        //LS
        NSURL *url = [NSURL URLWithString:@"http://cm.lskitchen.se/lindholmen/foodcourt/sv/today.rss"];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];

        
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
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LunchCell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString *desc =[[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    cell.detailTextLabel.text = desc;
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSArray *array = [string componentsSeparatedByString:@"@"];
    
    if ([element isEqualToString:@"title"] && !([string isEqualToString:@"Meny Food Court"])) {
        if([string isEqualToString:@"Dagens lunch"]){
            [title appendString:@"Kokboken"];
        } else {
            [title appendString:string];
        }
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"] && !([string isEqualToString:@"Meny Food Court"])) {
        [description appendString:array[0]];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}


@end
