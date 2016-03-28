//
//  RestaurantsTableViewController.h
//  iOS MPM
//
//  Created by guest on 3/21/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantsTableViewController : UITableViewController{
    

    NSMutableArray *allRestNames;
    NSMutableArray *allRestTypes;
    NSMutableArray *allRestAddresses;
    NSMutableArray *allRestDistances;
    NSMutableArray *allRestURLs;

    
}


@property (nonatomic, strong) NSString *clickedRestaurant;
@property (nonatomic, strong) NSString *clickedURL;








@end
