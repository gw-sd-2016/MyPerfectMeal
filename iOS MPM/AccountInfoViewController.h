//
//  AccountInfoViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nameLBL;
@property (strong, nonatomic) IBOutlet UILabel *locationLBL;
@property (strong, nonatomic) IBOutlet UILabel *userNameLBL;
- (IBAction)changePasswordBTN:(id)sender;

@end