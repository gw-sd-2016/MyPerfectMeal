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

//as many as the size of array
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [goalsArray count];
}

//set title for each row in the pickviewer
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectMedicationsBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showMedications" sender:self];
    //showMedications
}

- (IBAction)selectFoodAllergiesBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showFoodAllergies" sender:self];

}

- (IBAction)selectHealthDisordersBTN:(id)sender {
    
    [self performSegueWithIdentifier:@"showDisorders" sender:self];

}

- (IBAction)selectGoal:(id)sender {
    
    [self HideORShowPV];
}
@end
