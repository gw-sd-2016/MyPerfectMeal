//
//  SignUpViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstNameTF;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;


- (IBAction)signUpBTN:(id)sender;







@end
