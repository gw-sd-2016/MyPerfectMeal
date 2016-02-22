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

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

@synthesize nameLBL, locationLBL; //userNameLBL;



- (void)viewDidLoad {
    [super viewDidLoad];
   
    //displays (pulls from database and displays) user info
      
    //nameLBL.text = [NSString stringWithFormat:@"%@ %@", [[PFUser currentUser] valueForKey:@"First_Name"], [[PFUser currentUser] valueForKey:@"Last_Name" ]];
    //locationLBL.text = [NSString stringWithFormat:@"%@", [[PFUser currentUser] valueForKey:@"currentLocation"]];
    
    
    //NSLog(@"%@", [[PFUser currentUser] valueForKey:@"currentLocation"]);
    //userNameLBL.text = [NSString stringWithFormat:@"%@", [[PFUser currentUser] valueForKey:@"username"]];

    
    
    
    //NSLog(@"%@", [[PFUser currentUser] valueForKey:@"currentLocation"]);
    
  
    //display address in the location label
    PFGeoPoint *getCoordinates = [[PFUser currentUser] objectForKey:@"currentLocation"]; //grab the geo point
    double Latitude = getCoordinates.latitude; //set the lat to variable
    double Longitude = getCoordinates.longitude; //set the long to variable
    
    
    //NSLog(@"The lat is: %f and the long is: %f", Latitude, Longitude);

    //rever location protocol
    CLLocation *location = [[CLLocation alloc]  initWithLatitude:Latitude longitude:Longitude];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark= [placemarks objectAtIndex:0];
             
             //for full address use [placemark thoroughfare],[placemark locality],[placemark administrativeArea]];
             
             locationLBL.text = [NSString stringWithFormat:@"%@, %@" , [placemark locality], [placemark administrativeArea]];
             
             
         }
     }];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePasswordBTN:(id)sender {
    
    //allows user to change their password by sending them to the change password view controller
    
}
@end
