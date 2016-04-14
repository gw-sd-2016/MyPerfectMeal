//
//  UserProfileViewController.m
//  iOS MPM
//
//  Created by guest on 4/13/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "UserProfileViewController.h"
#import "LoginViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signOutBTN:(id)sender {
    
    [PFUser logOut];
    
    
    
}
@end
