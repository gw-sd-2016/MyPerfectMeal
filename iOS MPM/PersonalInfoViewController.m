//
//  PersonalInfoViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/29/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)selectMedicationsBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showMedications" sender:self];
    //showMedications view controller
}

- (IBAction)selectFoodAllergiesBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showFoodAllergies" sender:self];
    //show food allergies view controller

}

- (IBAction)selectHealthDisordersBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showDisorders" sender:self];
    //show disorders view controller

}

- (IBAction)selectGoal:(id)sender {
    
    [self performSegueWithIdentifier:@"showGoals" sender:self];
    //show goals view controller

}
@end
