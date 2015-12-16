//
//  SignUpViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "SignUpViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

/*
 
 Class summary:
 
 Allow the user to sign up. First check if the user has entered all info into the textfield, if no send a warning as a pop up. If everything checks ok, grab the user's location and send them to a "successful signup" view controller
 
 */
@interface SignUpViewController () <CLLocationManagerDelegate>

@end

@implementation SignUpViewController{
    
    //location manager used to send parse location of user when they sign up
    CLLocationManager *locationManager;

}

@synthesize firstNameTF, lastNameTF, userNameTF, passwordTF, emailTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signUpBTN:(id)sender {
    
    //create a user
    
    PFUser *user = [PFUser user];

    //user info entered in textfields
    user[@"First_Name"] = firstNameTF.text;
    user[@"Last_Name"] = lastNameTF.text;
    user.username = userNameTF.text;
    user.password = passwordTF.text;
    user.email = emailTF.text;
    
    
    //check if any of the textfields are missing
    if ([firstNameTF.text isEqualToString:@""] || firstNameTF.text == nil ||                                        [lastNameTF.text isEqualToString:@""] || lastNameTF.text == nil ||                                  [userNameTF.text isEqualToString:@""] || userNameTF.text == nil ||                                  [passwordTF.text isEqualToString:@""] || passwordTF.text == nil ||                                  [emailTF.text isEqualToString:@""] || emailTF.text == nil){
        
       
        //if there is something missing sned a warning popup
        UIAlertController *loginFailedWarning = [UIAlertController alertControllerWithTitle:@"Registration Failed"
                            message: @"Check Missing Inputs"
                            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Retry = [UIAlertAction
                                actionWithTitle:@"Retry"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [loginFailedWarning dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
        //animate close selection or retry selection
        [loginFailedWarning addAction: Retry];
    
        [self presentViewController:loginFailedWarning animated:YES completion:nil];
    }

    else{
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                //if there is nothing missing grab the user's location
                
                [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
                    //save the user location in parse
                    [[PFUser currentUser] setObject:geoPoint forKey:@"currentLocation"];
                    [[PFUser currentUser] saveInBackground];
                }];
                
                //after a successful signup send them to the successful signup view controller
                [self performSegueWithIdentifier:@"successSignup" sender:self];
                
                
            } else {   
                UIAlertController *loginFailedWarning = [UIAlertController alertControllerWithTitle:@"Registration Failed"
                                                                                            message: error.localizedDescription
                                                                                     preferredStyle:UIAlertControllerStyleAlert                   ];
                
                UIAlertAction *Retry = [UIAlertAction
                                        actionWithTitle:@"Retry"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [loginFailedWarning dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];
                
                [loginFailedWarning addAction: Retry];
                
                [self presentViewController:loginFailedWarning animated:YES completion:nil];
            }
        }];

    }
    
}
@end
