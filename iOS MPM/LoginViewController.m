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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)loginBTN:(id)sender {
    
    [PFUser logInWithUsernameInBackground:userNameTF.text password:passwordTF.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            [self performSegueWithIdentifier:@"LoginTOtab" sender:sender];
                                            
                                            
                                            
                                        } else {
                                            
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
    
}

@end
