//
//  newrestViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/6/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface newrestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *restaurantNameTF;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *stateTF;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTF;

- (IBAction)submitBTN:(id)sender;





@end
