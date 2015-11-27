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

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize firstNameTF, lastNameTF, userNameTF, passwordTF;

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

- (IBAction)signUpBTN:(id)sender {
    
    PFUser *user = [PFUser user];

    
    user[@"First_Name"] = firstNameTF.text;
    user[@"Last_Name"] = lastNameTF.text;
    user.username = userNameTF.text;
    user.password = passwordTF.text;

    
    if ([firstNameTF.text isEqualToString:@""] || firstNameTF.text == nil ||                                        [lastNameTF.text isEqualToString:@""] || lastNameTF.text == nil ||                                  [userNameTF.text isEqualToString:@""] || userNameTF.text == nil ||                                  [passwordTF.text isEqualToString:@""] || passwordTF.text == nil){
        
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
                
                [self performSegueWithIdentifier:@"successSignup" sender:self];
                
                
            } else {   NSString *errorString = [error userInfo][@"error"];
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
