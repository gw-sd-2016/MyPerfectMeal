//
//  ChangePasswordViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailResetTF;

- (IBAction)changePasswordBTN:(id)sender;

@end
