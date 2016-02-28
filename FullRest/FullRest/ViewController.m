//
//  ViewController.m
//  FullRest
//
//  Created by guest on 2/27/16.
//  Copyright © 2016 AKSolutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController





-(NSString *) loadRawHTML{
    
    //load url of near me restaurants
    NSMutableString *loadURL= [NSMutableString stringWithFormat:@"http://allmenus.com/custom-results/lat/38.8991833/long/-77.048883/"];
    
    //Load HTML link
    NSURL *allRestNearMeURL = [[NSURL alloc] initWithString:loadURL];
    //Store HTML Page for "X amount of restaurants Page"
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:allRestNearMeURL];
    
    
    NSScanner *allRestNearMeHTMLScanner;
    NSString *text = @"";
    allRestNearMeHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([allRestNearMeHTMLScanner isAtEnd] == NO) {
        
        [allRestNearMeHTMLScanner scanUpToString:@"<" intoString:NULL] ;
        [allRestNearMeHTMLScanner scanUpToString:@">" intoString:&text] ;
        
        
    }
    
    //NSLog(@"%@", loadPageHTML);
    
    return loadPageHTML;
    
}


-(NSInteger *) NumOfRestNearMe{
    
    NSScanner *numOfRestNearMeScanner;
    NSString *getNumOfRestNearMe = nil;
    
    numOfRestNearMeScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([numOfRestNearMeScanner isAtEnd] == NO) {
        
        
        [numOfRestNearMeScanner scanUpToString:@"<h1>We found <span id='rest_count'>" intoString:NULL] ;
        
        [numOfRestNearMeScanner scanUpToString:@"</span>" intoString:&getNumOfRestNearMe] ;
        
        getNumOfRestNearMe = [getNumOfRestNearMe stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<h1>We found <span id='rest_count'>"] withString:@""];
        
        
        
    }
    
    return [getNumOfRestNearMe integerValue];
}


-(NSString *) RestURL{
    
    NSScanner *getRestURLScanner;
    NSString *getRestURL = nil;
    
    getRestURLScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestURLScanner isAtEnd] == NO) {
        
        
        [getRestURLScanner scanUpToString:@"<p class=\"restaurant_name\"><a href=\"" intoString:NULL] ;
        
        [getRestURLScanner scanUpToString:@"menu/\">" intoString:&getRestURL] ;
        
       getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_name\"><a href=\""] withString:@""];
        
        //this gets all urls on the page
        //NSLog(@"%@", getRestURL);
        
    }
    
    return getRestURL;
}


- (NSString *) RestNames{
    
    NSScanner *getRestNamesScanner;
    NSString *getRestNames = nil;
    
    getRestNamesScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestNamesScanner isAtEnd] == NO) {
        
        
        [getRestNamesScanner scanUpToString:@"/menu/\">" intoString:NULL] ;
        
        [getRestNamesScanner scanUpToString:@"</a></p>" intoString:&getRestNames] ;
        
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/menu/\">"] withString:@""];
        
        
        //get all rest names
        NSLog(@"%@", getRestNames);
        
    }
    
    return getRestNames;
    
    
    
    
}

- (double) RestDistances{
    
    NSScanner *getRestDistanceScanner;
    NSString *getRestDistance = nil;
    
    getRestDistanceScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestDistanceScanner isAtEnd] == NO) {
        
        
        [getRestDistanceScanner scanUpToString:@"<p class=\"restaurant_distance\">" intoString:NULL] ;
        
        [getRestDistanceScanner scanUpToString:@" miles</p>" intoString:&getRestDistance] ;
        
        getRestDistance = [getRestDistance stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_distance\">"] withString:@""];
        
        
        //get all rest names
        NSLog(@"%f", [getRestDistance doubleValue]);
        
    }
    
    return [getRestDistance doubleValue];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Get number of restaurants found around me
   // NSLog(@"%d", [self NumOfRestNearMe]);
    
    //get all rest urls near me
    //NSLog(@"%@", [self RestURL]);
    
    //get all rest names near me
    //NSLog(@"%@", [self RestNames]);
    
    //get all rest distances
    //NSLog(@"%f", [self RestDistances]);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
