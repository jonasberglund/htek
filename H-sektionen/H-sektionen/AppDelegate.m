//
//  AppDelegate.m
//  H-sektionen
//
//  Created by Jonas Berglund on 2013-10-23.
//  Copyright (c) 2013 Jonas Berglund. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
        return [NSString stringWithFormat:@"Om %d år", years];
    else if (months == 1)
        return @"Nästa månad";
    else if (months > 1)
        return [NSString stringWithFormat:@"Om %d månader", months];
    else if (days == 1)
        return [NSString stringWithFormat:@"I morgon %@", clock];
    else if (days > 1)
        return [NSString stringWithFormat:@"Om %d dagar", days];
    
    return [NSString stringWithFormat:@"Idag %d %@", days, clock];
}


@end
