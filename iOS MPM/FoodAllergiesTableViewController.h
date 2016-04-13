//
//  FoodAllergiesTableViewController.h
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodAllergiesTableViewController : UITableViewController{
    
    //store food allergies pulled from database
    NSMutableArray *foodAllergies;
    NSMutableArray *selectedAllergies;
    NSMutableArray *findSelectedAllergies;
    
}

@end
