//
//  AccountInfoViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface AccountInfoViewController : UIViewController{
    CLGeocoder *geocoder;
}

@property (strong, nonatomic) IBOutlet UILabel *nameLBL;
@property (strong, nonatomic) IBOutlet UILabel *locationLBL;

//@property (strong, nonatomic) IBOutlet UILabel *userNameLBL;

- (IBAction)getUserLocationBTN:(id)sender;

- (IBAction)changePasswordBTN:(id)sender;

@end
