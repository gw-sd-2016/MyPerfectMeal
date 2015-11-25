//
//  newIngViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/24/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "newIngViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface newIngViewController ()

@end

@implementation newIngViewController

@synthesize ingNameTF;


- (IBAction)submitBTN:(id)sender {
    //set the user input from the textfield to a new string
   
    NSString *ingName = [ingNameTF.text capitalizedString];
    
    PFObject *object = [PFObject objectWithClassName:@"Restaurants"];
    
    //submition
    //[object setObject:restaurantName forKey:@"Restaurant_Name"];
    //[object setObject:streetAddress forKey:@"Street_Address"];
    
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        // Refresh the table when the object is done saving.
        
    }];
    
    

}
@end
