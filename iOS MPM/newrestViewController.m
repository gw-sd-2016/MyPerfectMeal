//
//  newrestViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/6/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "newrestViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface newrestViewController ()

@end

@implementation newrestViewController
@synthesize restaurantNameTF, streetAddressTF, cityTF, stateTF, zipCodeTF;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBTN:(id)sender {
    
    //set the user input from the textfield to a new string
    NSString *restaurantName = [restaurantNameTF.text capitalizedString];
    NSString *streetAddress = [streetAddressTF.text capitalizedString];
    NSString *city = [cityTF.text capitalizedString];
    NSString *state = [stateTF.text capitalizedString];
    NSString *zip = [zipCodeTF.text capitalizedString];

    //get first char
    NSString *firstLetter = [restaurantName substringToIndex:1];
    
    
    
    
    PFObject *object = [PFObject objectWithClassName:@"Restaurants"];
    
    //submition
    [object setObject:restaurantName forKey:@"Restaurant_Name"];
    [object setObject:streetAddress forKey:@"Street_Address"];
    [object setObject:city forKey:@"City"];
    [object setObject:state forKey:@"State"];
    [object setObject:zip forKey:@"Zip"];
    [object setObject:firstLetter forKey:@"Starts_With"];
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
        // Refresh the table when the object is done saving.
        
    }];
    
    
    
}
@end
