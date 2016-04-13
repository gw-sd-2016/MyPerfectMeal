//
//  GoalsTableViewController.h
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalsTableViewController : UITableViewController{
    
    //store all health goals in this array
    NSMutableArray *healthGoals;
    NSMutableString *findSelectedGoal;
}

@end
