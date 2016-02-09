//
//  AppDelegate.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/5/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "AppDelegate.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse enableLocalDatastore];
     // Initialize Parse.
        
    [PFUser enableRevocableSessionInBackground];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    //Default nav bar color
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:177/255.0 green:250/255.0 blue:255/255.0 alpha:1.0]];
    
    /*
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:207/255.0 blue:255/255.0 alpha:1.0]}];
     */
    /*
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
*/
    //font, size, and color of nav bar set at launch of app
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:20], NSForegroundColorAttributeName : [UIColor colorWithRed:0/255.0 green:207/255.0 blue:255/255.0 alpha:1.0]}];
    
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    
    // Override point for customization after application launch.
    

    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
