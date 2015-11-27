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

@synthesize ingNameTF, ingMealIndexNumber, ingMealIndex, clickedRestaurant5;


-(void) viewDidLoad{
    //NSLog(@"meal number is %d and all of the string is %@", ingMealIndexNumber, ingMealIndex );
    //NSLog(@"clicked restaurant is: %@", clickedRestaurant5);
}

- (IBAction)submitBTN:(id)sender {
    //set the user input from the textfield to a new string
   

    NSString *ingName = [ingNameTF.text capitalizedString];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:clickedRestaurant5];

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
               // NSLog(@"%@", objects);
                
                
                for (int i = 0; i <=9 ; i++){
                    ingLookUp = [NSMutableString stringWithFormat:@"Ing%ld%d", ingMealIndexNumber, i];
                    // NSLog(@"%@", ingLookUp);
                    
                    if (object[ingLookUp]) {
                        //NSLog(@"FOUND SOMETHING AT %@", ingLookUp);
                        [Ingredients addObject:[object objectForKey:ingLookUp]];
                        NSLog(@"FOUND %@ AT %@",[object objectForKey:ingLookUp] ,  ingLookUp);
                        
                        //NSLog(@"%@", Ingredients);
                        
                    }
                    else{
                        
                        [object setObject:ingName forKey:ingLookUp];
                        [object save];
                        break;
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }];

    


}
@end
