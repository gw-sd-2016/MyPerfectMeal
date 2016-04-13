//
//  PersonalInfoViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/29/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Meds" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    findUserSelections = [[NSMutableArray alloc] init];
    MedsArray = [[NSArray alloc] init];
    NSMutableString *currentMed = [[NSMutableString alloc] init];
    
    
    

    //NSLog(@"%@",[dict objectForKey:@"DrugName"]);
    //NSLog(@"%@", dict);
    
    
    
    [findUserSelections addObject:[[PFUser currentUser] objectForKey:@"selectedGoal"]];
    [findUserSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedMeds"]];
    [findUserSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedFoodAllergy"]];
    [findUserSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedDisorder"]];

    //NSLog(@"The user selections are %@", findUserSelections);
    
    
    
    //find path of plist of our Meds
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Meds" ofType:@"plist"];
    NSDictionary *medsDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    MedsArray = medsDictionary[@"Meds"];
    
    for (int i = 0; i <= (findUserSelections.count-1); i++){
        //get individual user selection
        //NSLog(@"%@", findUserSelections[i]);
        //NSLog(@"");
        
    
        
        /*//Find What selected drugs are for
        for (int j= 0; j <= (MedsArray.count -1); j++){
            //get all names in medsArray
            //NSLog(@"%@", MedsArray[j][@"Name"]);
            currentMed = MedsArray[j][@"Name"];
            
            if ([findUserSelections[i] isEqualToString:currentMed] ){
               // NSLog(@"Found %@ in The User's Selection and this is a %@", currentMed, MedsArray[j][@"Type"]);
               // NSLog(@"%@", MedsArray[j]);
            }
        }
        */
        
        

        
    }
    
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
