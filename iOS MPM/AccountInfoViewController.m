//
//  AccountInfoViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/27/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "AccountInfoViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

@synthesize nameLBL, locationLBL, userNameLBL;

- (void)viewDidLoad {
    [super viewDidLoad];
   
      
    nameLBL.text = [NSString stringWithFormat:@"%@ %@", [[PFUser currentUser] valueForKey:@"First_Name"], [[PFUser currentUser] valueForKey:@"Last_Name" ]];
    locationLBL.text = [NSString stringWithFormat:@"%@", [[PFUser currentUser] valueForKey:@"currentLocation"]];
    NSLog(@"%@", [[PFUser currentUser] valueForKey:@"currentLocation"]);
    userNameLBL.text = [NSString stringWithFormat:@"%@", [[PFUser currentUser] valueForKey:@"username"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changePasswordBTN:(id)sender {
    
}
@end
