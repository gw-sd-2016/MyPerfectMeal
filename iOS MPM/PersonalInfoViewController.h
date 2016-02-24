//
//  PersonalInfoViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/29/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoViewController : UIViewController

{
    
    //save all goals in goal array
    NSMutableArray *goalsArray;
    
    //find user selections as soon as they login
    NSMutableArray *findSelections;
    
}

//varions and uipicker for the personal info container
- (IBAction)selectMedicationsBTN:(id)sender;
- (IBAction)selectFoodAllergiesBTN:(id)sender;
- (IBAction)selectHealthDisordersBTN:(id)sender;
- (IBAction)selectGoal:(id)sender;

//plist meds
@property (strong, nonatomic) NSArray *MedsArray;









@end
