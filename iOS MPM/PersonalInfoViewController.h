//
//  PersonalInfoViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/29/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    NSMutableArray *goalsArray;
    
}
- (IBAction)selectMedicationsBTN:(id)sender;
- (IBAction)selectFoodAllergiesBTN:(id)sender;
- (IBAction)selectHealthDisordersBTN:(id)sender;
- (IBAction)selectGoal:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *selectedGoalLBL;
@property (strong, nonatomic) IBOutlet UIPickerView *selectGoalsPV;


@end
