//
//  MealTableTableViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/13/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <ParseUI/ParseUI.h>

@interface MealTableTableViewController : PFQueryTableViewController <UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray *Meals; 
    NSMutableString *mealLookUp;
    NSString *clickedMeal;
    
    
}

@property (nonatomic, strong) NSString *clickedRestaurant;




@end
