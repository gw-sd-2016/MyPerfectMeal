//
//  newMealViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/18/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "newMealViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface newMealViewController ()


@end

@implementation newMealViewController
@synthesize mealNameTF, numMeals;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //NSLog(@"%d", numMeals + 1);


  }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addMealBTN:(id)sender {
    
    
    NSString *mealName = [mealNameTF.text capitalizedString];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:_clickedRestaurant3];
    
    emptyMeal = [NSMutableString stringWithFormat:@"Meal%ld", numMeals + 1];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            for (PFObject *object in objects) {
                
                [object setObject:mealName forKey:emptyMeal];
                [object save];

            }
            
            
        }
        
        
    }];

    

}
@end
