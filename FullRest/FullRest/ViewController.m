//
//  ViewController.m
//  FullRest
//
//  Created by guest on 2/27/16.
//  Copyright © 2016 AKSolutions. All rights reserved.
//

#import "ViewController.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ViewController ()

@end

@implementation ViewController





-(NSString *) loadRawHTML{
    
    //load url of near me restaurants
    NSURL *loadURL = [[NSURL alloc] initWithString:@"http://allmenus.com/custom-results/lat/38.8991833/long/-77.048883/"];
    NSStringEncoding encoding;
    NSError *error = nil;
    //Load HTML link
    //Store HTML Page for "X amount of restaurants Page"
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:loadURL
                                                         usedEncoding:&encoding
                                                                error:&error];

  
    
    
    NSScanner *allRestNearMeHTMLScanner;
    NSString *text = @"";
    allRestNearMeHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([allRestNearMeHTMLScanner isAtEnd] == NO) {
        
        //[allRestNearMeHTMLScanner scanUpToString:@"<" intoString:NULL] ;
        //[allRestNearMeHTMLScanner scanUpToString:@">" intoString:&text] ;
        //[allRestNearMeHTMLScanner scanUpToString:@"<h1>We found <span id='rest_count'>" intoString:NULL] ;

        [allRestNearMeHTMLScanner scanUpToString:@"delivery_option_label>" intoString:NULL] ;
        [allRestNearMeHTMLScanner scanUpToString:@"2016 GrubHub, Inc. All rights reserved." intoString:&text] ;
        
        
    }
    
    NSLog(@"%@", loadPageHTML);
    
    return loadPageHTML;
    
}

/*
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


-(NSMutableArray *) RestURL{
    
    NSScanner *getRestURLScanner;
    NSString *getRestURL = nil;
    NSMutableArray *getRestURLArray = [[NSMutableArray alloc] init];
    getRestURLScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestURLScanner isAtEnd] == NO) {
        
        
        [getRestURLScanner scanUpToString:@"<p class=\"restaurant_name\"><a href=\"" intoString:NULL] ;
        
        [getRestURLScanner scanUpToString:@"menu/\">" intoString:&getRestURL] ;
        
        getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_name\"><a href=\""] withString:@""];
        
        
        /*
        //this gets all urls on the page
        //NSLog(@"%@", getRestURL);
        
        if (![getRestURLArray containsObject:getRestURL]){
            [getRestURLArray addObject:getRestURL];

        }
        else{
            //NSLog(@" found before %@", getRestURL);
        }
 
        [getRestURLArray addObject:getRestURL];

        
        
    }
    
    [getRestURLArray removeLastObject];
    
    return getRestURLArray;
}


- (NSMutableArray *) RestNames{
    
    NSScanner *getRestNamesScanner;
    NSString *getRestNames = nil;
    NSMutableArray *getRestNamesArray = [[NSMutableArray alloc] init];
    getRestNamesScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestNamesScanner isAtEnd] == NO) {
        
        
        [getRestNamesScanner scanUpToString:@"/menu/\">" intoString:NULL] ;
        
        [getRestNamesScanner scanUpToString:@"</a></p>" intoString:&getRestNames] ;
        
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/menu/\">"] withString:@""];
        
        
        //get all rest names
        //NSLog(@"%@", getRestNames);
 
        if (![getRestNamesArray containsObject:getRestNames]){
            [getRestNamesArray addObject:getRestNames];
            
        }
        else{
            NSLog(@" found before %@", getRestNames);
        }
 
        
        [getRestNamesArray addObject:getRestNames];
    }
    
    [getRestNamesArray removeLastObject];
    
    return getRestNamesArray;
    
    
    
    
}

- (NSMutableArray *) RestDistances{
    
    NSScanner *getRestDistanceScanner;
    NSString *getRestDistance = nil;
    NSMutableArray *getRestDistanceArray = [[NSMutableArray alloc] init];
    getRestDistanceScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestDistanceScanner isAtEnd] == NO) {
        
        
        [getRestDistanceScanner scanUpToString:@"<p class=\"restaurant_distance\">" intoString:NULL] ;
        
        [getRestDistanceScanner scanUpToString:@" miles</p>" intoString:&getRestDistance] ;
        
        getRestDistance = [getRestDistance stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_distance\">"] withString:@""];
        
        
        //get all rest names
        //NSLog(@"%f", [getRestDistance doubleValue]);
        
        [getRestDistanceArray addObject:getRestDistance];

        
    }
    
    [getRestDistanceArray removeLastObject];

    
    return  getRestDistanceArray;
    
}


- (NSMutableArray *) RestDesc{
    
    NSScanner *getRestDescScanner;
    NSString *getRestDesc = nil;
    NSMutableArray *getRestDescArray = [[NSMutableArray alloc] init];
    getRestDescScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestDescScanner isAtEnd] == NO) {
        
        
        [getRestDescScanner scanUpToString:@"<ul class=\"restaurant_cuisines\">" intoString:NULL] ;
        
        [getRestDescScanner scanUpToString:@"</li>        </ul>" intoString:&getRestDesc] ;
        
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<ul class=\"restaurant_cuisines\">"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<li>"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</li>"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"        "] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:@"\n" withString:@""];

        [getRestDescArray addObject:getRestDesc];

        
        //get all rest names
        //NSLog(@"%@", getRestDesc);
        
    }
    
    [getRestDescArray removeLastObject];
    
    return getRestDescArray;
    
}


- (NSMutableArray *) RestAddress{
    
    NSScanner *getRestAddressScanner;
    NSString *getRestAddress = nil;
    NSMutableArray *getRestAddressArray = [[NSMutableArray alloc] init];
    getRestAddressScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getRestAddressScanner isAtEnd] == NO) {
        
        
        [getRestAddressScanner scanUpToString:@"<p class=\"restaurant_address\">" intoString:NULL] ;
        
        [getRestAddressScanner scanUpToString:@"</p>" intoString:&getRestAddress] ;
        
        getRestAddress = [getRestAddress stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_address\">"] withString:@""];
    
        //get all rest names
        //NSLog(@"%@", getRestAddress);
        
        
        [getRestAddressArray addObject:getRestAddress];

        
    }
    
    [getRestAddressArray removeLastObject];
    
    
    return getRestAddressArray;
    
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRawHTML];
    
    //Get number of restaurants found around me
    //NSLog(@"%d", [self NumOfRestNearMe]);
    
    //get all rest urls near me
    //NSLog(@"%@", [self RestURL]);
    //NSLog(@"%d", [[self RestURL] count]);
   // NSLog(@"%@", [self RestURL][5]);
    
    
    //get all rest names near me
    //NSLog(@"%@", [self RestNames]);
    //NSLog(@"%d", [[self RestNames] count]);
    //NSLog(@"%@", [self RestNames][5]);


    //get all rest distances
    //NSLog(@"%f", [self RestDistances]);
    //NSLog(@"%d", [[self RestDistances] count]);
    //NSLog(@"%@", [self RestDistances][5]);

    
    //get all rest desc near me
    //NSLog(@"%@", [self RestDesc]);
    //NSLog(@"%d", [[self RestDesc] count]);
    //NSLog(@"%@", [self RestDesc][5]);

    //get all rest address near me
    //NSLog(@"%@", [self RestAddress]);
    //NSLog(@"%d", [[self RestAddress] count]);
   // NSLog(@"%@", [self RestAddress][5]);


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
