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

@synthesize selectGoalsPV, selectedGoalLBL;


// one column
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//as many as the size of array we populated
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [goalsArray count];
}

//set title for each row in the pickviewer using the array populated
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [goalsArray objectAtIndex:row];
}


//selection displayed on label from row of selection
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [selectedGoalLBL setText: [goalsArray objectAtIndex:row]];
    
}

//preset the PV to hidden before starting
//on/off switch for pick viewer
-(void) HideORShowPV{
    if([selectGoalsPV isHidden]){ //initially this is true, turned off in the storyboard
        
        [selectGoalsPV setHidden:NO];
        
    }
    else{
        [selectGoalsPV setHidden:YES];
    }
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    goalsArray = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", nil];


    
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
    
    [self HideORShowPV];
}
@end
