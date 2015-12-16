//
//  FoodAllergiesViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 12/1/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <ParseUI/ParseUI.h>

@interface FoodAllergiesViewController : PFQueryTableViewController {
    
    //store food allergies pulled from database
    NSMutableArray *foodAllergies;
}

@end
