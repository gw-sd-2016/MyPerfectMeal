//
//  RestaurantViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/5/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>

@interface RestaurantViewController : PFQueryTableViewController

@property (nonatomic, strong) NSMutableDictionary *sections;
@property (nonatomic, strong) NSMutableDictionary *sectionToStarts_WithMap;



@end
