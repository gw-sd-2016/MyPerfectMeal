//
//  LoginViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>


/*
 
 Class summary:
 
 Allow the user to sign in. First check if the user has an account, if no send a warning as a pop up. If everything checks ok, login and send them to the user profile tab. if the user hits signup, send them to registration view controller
 
 */



@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize userNameTF, passwordTF;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)loginBTN:(id)sender {
    
    //check if the user is in the database
    
    [PFUser logInWithUsernameInBackground:userNameTF.text password:passwordTF.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            //if user is logged in send them to the Login to tab segue (which will take them to the User Profile)
                                            
                                            [self performSegueWithIdentifier:@"LoginTOtab" sender:sender];
                                            
                                            
                                            
                                        } else {
                                            
                                            //if user does not exist, warn them with a pop up
                                            
                                            UIAlertController *loginFailedWarning = [UIAlertController alertControllerWithTitle:@"Login Failed"
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

- (IBAction)signUpBTN:(id)sender{
    //signup button will take the user to the segue to allow them to signup 
}

@end
