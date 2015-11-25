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
                
                City = [object objectForKey:@"City"];
                State = [object objectForKey:@"State"];
                Zip = [object objectForKey:@"Zip"];
                AddressOne = [object objectForKey:@"Street_Address"];
                
                CityStateZipCombo = [NSString stringWithFormat:@"%@, %@, %@",City,State,Zip];

                self.nameLbl.text = [object objectForKey:@"Restaurant_Name"];
                self.addressOneLbl.text = AddressOne;
                self.addressTwoLbl.text = CityStateZipCombo;

                NSString *fullAddress = [NSString stringWithFormat:@"%@, %@", AddressOne, CityStateZipCombo];
                NSString *location = fullAddress;
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                [geocoder geocodeAddressString:location
                             completionHandler:^(NSArray* placemarks, NSError* error){
                                 if (placemarks && placemarks.count > 0) {
                                     CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                     MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                     
                                     MKCoordinateRegion region = self.restaurantMap.region;
                                     region.center = placemark.location.coordinate;
                                     region.span.longitudeDelta /= 5000;
                                     region.span.latitudeDelta /= 5000;
                                     
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
