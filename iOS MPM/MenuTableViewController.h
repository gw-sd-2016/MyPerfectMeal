//
//  MenuTableViewController.h
//  iOS MPM
//
//  Created by guest on 3/23/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController{
    
    NSMutableDictionary *Meals;
    NSArray *MealSectionTitles;
    
}


@property (nonatomic, strong) NSString *clickedRestaurantName;
@property (nonatomic, strong) NSString *clickedRestaurantURL;




@end
