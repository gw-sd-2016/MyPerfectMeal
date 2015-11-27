//
//  ChangePasswordViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize emailResetTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changePasswordBTN:(id)sender {
    

    if( [emailResetTF.text isEqualToString:@""] || emailResetTF.text == nil ){
        
        UIAlertController *resetFailed = [UIAlertController alertControllerWithTitle:@"Reset Failed"
                                                                                    message: @"Check Inputs"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Retry = [UIAlertAction
                                actionWithTitle:@"Retry"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [resetFailed dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
        
        [resetFailed addAction: Retry];
        
        [self presentViewController:resetFailed animated:YES completion:nil];
        
    }

    else{
        
        [PFUser requestPasswordResetForEmailInBackground:emailResetTF.text];
        
        UIAlertController *resetSuccess = [UIAlertController alertControllerWithTitle:@"Reset Instructions Sent"
                                                                              message: @"Check Email"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [resetSuccess dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [resetSuccess addAction: ok];
        
        [self presentViewController:resetSuccess animated:YES completion:nil];
        //add segue
        
        [self performSegueWithIdentifier:@"resetSuccess" sender:self];

       
    }
   
    
}


@end
