//
//  AccountInfoViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "AccountInfoViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "RestaurantsTableViewController.h"


@interface AccountInfoViewController () <MKMapViewDelegate>{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;


}

@end

@implementation AccountInfoViewController

@synthesize nameLBL, locationLBL;


- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init] ;
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    
    nameLBL.text = [NSString stringWithFormat:@"%@ %@", [[PFUser currentUser] valueForKey:@"First_Name"], [[PFUser currentUser] valueForKey:@"Last_Name" ]];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getUserLocationBTN:(id)sender {
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
        
    }
    [locationManager startUpdatingLocation];
    
    float Lat = locationManager.location.coordinate.latitude;
    float Lon = locationManager.location.coordinate.longitude;
    
    NSString *LatString = [NSString stringWithFormat:@"%f", Lat];
    NSString *LonString = [NSString stringWithFormat:@"%f", Lon];

    NSLog(@"Lat : %@  Lon : %@",LatString,LonString);


    
     [[PFUser currentUser] addObject:LatString forKey:@"LatStringArray"];
     [[PFUser currentUser] saveInBackground];
     [[PFUser currentUser] addObject:LonString forKey:@"LonStringArray"];
     [[PFUser currentUser] saveInBackground];
    
    
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       //NSLog(@"placemark.ISOcountryCode %@", placemark.ISOcountryCode);
                       //NSLog(@"placemark.ISOcountryCode %@", placemark.locality);
                       locationLBL.text = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.administrativeArea];
                       
                   }];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       locationLBL.text = [NSString stringWithFormat:@"%@, %@", placemark.locality, placemark.administrativeArea];
                       
                   }];
}




- (IBAction)changePasswordBTN:(id)sender {
    
    //allows user to change their password by sending them to the change password view controller
    
}
@end
