//
//  LoginViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)signUpBTN:(id)sender;

//grab the user input
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;


- (IBAction)loginBTN:(id)sender;

@end
