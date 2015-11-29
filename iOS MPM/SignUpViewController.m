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

@interface SignUpViewController () <CLLocationManagerDelegate>

@end

@implementation SignUpViewController{
    
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
    
    PFUser *user = [PFUser user];

    
    user[@"First_Name"] = firstNameTF.text;
    user[@"Last_Name"] = lastNameTF.text;
    user.username = userNameTF.text;
    user.password = passwordTF.text;
    user.email = emailTF.text;
    
    
    
    if ([firstNameTF.text isEqualToString:@""] || firstNameTF.text == nil ||                                        [lastNameTF.text isEqualToString:@""] || lastNameTF.text == nil ||                                  [userNameTF.text isEqualToString:@""] || userNameTF.text == nil ||                                  [passwordTF.text isEqualToString:@""] || passwordTF.text == nil ||                                  [emailTF.text isEqualToString:@""] || emailTF.text == nil){
        
       
        //error
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
        
        [loginFailedWarning addAction: Retry];
        
        [self presentViewController:loginFailedWarning animated:YES completion:nil];
    }

    else{
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                
                
                [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
                    
                    [[PFUser currentUser] setObject:geoPoint forKey:@"currentLocation"];
                    [[PFUser currentUser] saveInBackground];
                }];
                
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
