//
//  newMealViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/18/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newMealViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *mealNameTF;
- (IBAction)addMealBTN:(id)sender;

@property (nonatomic, strong) NSString *clickedRestaurant3;


@end
