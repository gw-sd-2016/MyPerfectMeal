//
//  MedsTableViewController.h
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedsTableViewController : UITableViewController{
    
    //store medications
    NSMutableArray *Medications;
    NSMutableArray *selectedMeds;
    NSMutableArray *findSelectedMeds;

}

@end
