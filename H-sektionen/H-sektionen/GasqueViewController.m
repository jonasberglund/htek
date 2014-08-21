//
//  ViewController.m
//  Är det ...?
//
//  Created by Jonas Berglund on 2013-11-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "GasqueViewController.h"
#import "MenuViewController.h"
@interface GasqueViewController ()

@end

@implementation GasqueViewController{
    NSArray *lunches;
    NSXMLParser *parser;
    NSXMLParser *parserKokboken;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *description;
    NSString *element;
    NSString *currentTime;
    NSString *today;
    NSString *tomorrow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d/M"];
    today = [dateFormatter stringFromDate:[NSDate date]];
    tomorrow = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:60*60*24]];
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadGasque)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
	[self loadGasque];
}



- (void)loadGasque{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Spinner
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            feeds = [[NSMutableArray alloc] init];
            
            NSString *connect = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://gasquen.se"] encoding:NSUTF8StringEncoding error:nil];
            
            if(connect == NULL){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Felmeddelande" message:@"Kontrollera din interwebsanslutning" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                _isItTodayLabel.hidden = true;
                [_descToday setHidden:YES];
                [_descTomorrow setHidden:YES];
            }else{
                _isItTodayLabel.hidden = false;
                [_descToday setHidden:NO];
                [_descTomorrow setHidden:NO];
            }
            
            NSURL *url = [NSURL URLWithString:@"http://gasquen.chs.chalmers.se/rss.php"];
            parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
            
            [parser setDelegate:self];
            [parser setShouldResolveExternalEntities:NO];
            [parser parse];
            
                       [spinner stopAnimating];
      
            
            
        });
        
    });

    
    
    
   
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"title"]) {
        
        [title appendString:string];
        
        
    } else if ([element isEqualToString:@"description"]) {
        
        
        [description appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
        
        NSArray *array = [title componentsSeparatedByString:@" "];
        NSArray *array2 = [array[1] componentsSeparatedByString:@"/"];
        NSInteger d = [array2[0] integerValue];
        NSInteger m = [array2[1] integerValue];
        
        if(array.count > 1){
            //NSString *date = [array[1] substringToIndex:5];
            NSString *date = [NSString stringWithFormat:@"%ld/%ld", (long)d, (long)m];
            
            if([date isEqualToString:today]){
               [self.isItTodayLabel  setText:@"JA!"];
               _descToday.text = description;
            }
            
            if([date isEqualToString:tomorrow]){
                [self.isItTomorrowLabel  setText:@"JA!"];
                _descTomorrow.text = description;
            }
        }
    }
    
    
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)showMenu {
    [self.sideMenuViewController presentMenuViewController];
}

@end
