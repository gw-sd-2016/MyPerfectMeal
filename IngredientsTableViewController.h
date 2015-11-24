//
//  IngredientsTableViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/23/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <ParseUI/ParseUI.h>

@interface IngredientsTableViewController : PFQueryTableViewController{
    NSMutableArray *Ingredients;
    NSMutableString *ingLookUp;
}


@property (nonatomic, strong) NSString *clickedMeal2;
@property (nonatomic, strong) NSString *clickedRestaurant4;
@property NSInteger mealIndex;


@end
