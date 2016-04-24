//
//  CustomResultsTableViewCell.h
//  iOS MPM
//
//  Created by guest on 4/23/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomResultsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *restNameLBL;
@property (weak, nonatomic) IBOutlet UILabel *restTypeLBL;
@property (weak, nonatomic) IBOutlet UILabel *restAddressLBL;
@property (weak, nonatomic) IBOutlet UILabel *restDistanceLBL;
@property (weak, nonatomic) IBOutlet UILabel *restMealNameLBL;
@property (weak, nonatomic) IBOutlet UILabel *restMealDescriptionLBL;

@end
