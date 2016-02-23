//
//  MapContainerViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/17/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "MapContainerViewController.h"
#import "RestaurantViewController.h"
#import "MealTableTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MapContainerViewController ()

@end

@implementation MapContainerViewController

@synthesize restaurantMap;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    
    //we know which restaurant we clicked on because we passed the info from the previous view controller
    [query whereKey:@"Restaurant_Name" equalTo:_clickedRestaurant2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                //NSLog(@"%@", object);
                NSString *CityStateZipCombo;
                NSString *City;
                NSString *State;
                NSString *Zip;
                NSString *AddressOne;
                
                //pull info from database
                City = [object objectForKey:@"City"];
                State = [object objectForKey:@"State"];
                Zip = [object objectForKey:@"Zip"];
                AddressOne = [object objectForKey:@"Street_Address"];
                
                //we have a full address now because we combined the pulled info
                CityStateZipCombo = [NSString stringWithFormat:@"%@, %@, %@",City,State,Zip];

                //set the info of the restaurant
                self.nameLbl.text = [object objectForKey:@"Restaurant_Name"];
                self.addressOneLbl.text = AddressOne;
                self.addressTwoLbl.text = CityStateZipCombo;

                //use the apple's geocoder to translate an address to logng and lat
                NSString *fullAddress = [NSString stringWithFormat:@"%@, %@", AddressOne, CityStateZipCombo];
                NSString *location = fullAddress;
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                [geocoder geocodeAddressString:location
                             completionHandler:^(NSArray* placemarks, NSError* error){
                                 if (placemarks && placemarks.count > 0) {
                                     //placemark for the first result
                                     CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                     MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                     
                                     //formating info
                                     MKCoordinateRegion region = self.restaurantMap.region;
                                     region.center = placemark.location.coordinate;
                                     region.span.longitudeDelta /= 5000;
                                     region.span.latitudeDelta /= 5000;
                                     
                                     //animation and display the address on the map
                                     [self.restaurantMap setRegion:region animated:false];
                                     [self.restaurantMap addAnnotation:placemark];
                                     [self.view addSubview:restaurantMap];
                                     
                                 }
                             }
                 ];

                
            }
            
            
        }
        
    }];

    
 
    
    
    
    
 
 

}



@end
