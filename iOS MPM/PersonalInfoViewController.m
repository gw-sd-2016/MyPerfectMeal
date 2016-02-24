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
    findSelections = [[NSMutableArray alloc] init];


    //NSLog(@"%@",[dict objectForKey:@"DrugName"]);
    //NSLog(@"%@", dict);
    
    
    
    [findSelections addObject:[[PFUser currentUser] objectForKey:@"selectedGoal"]];
    [findSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedMeds"]];
    [findSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedFoodAllergy"]];
    [findSelections addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedDisorder"]];

   // NSLog(@"the user selections are %@", findSelections);
    
    //find path of plist of our Meds
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Meds" ofType:@"plist"];
    NSDictionary *medsDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    self.MedsArray = medsDictionary[@"Meds"];
    
    //NSLog(@"%@", self.MedsArray);
    
    //NSLog(@"%@", self.MedsArray[2][@"Type"]);
    
    NSMutableString *findSelections = [[NSMutableString alloc] init];
    
    //findSelections = self.MedsArray[2][@"Name"];
    
    
    for (int i=0; i <= (self.MedsArray.count-1); i++){
        
        findSelections = self.MedsArray[i][@"Name"];
        
        //NSLog(@"found selections %@", findSelections);
       
        if ([findSelections isEqualToString:@"Zanaflex"]){
            NSLog(@"found drug the type is %@: ", self.MedsArray[i][@"Type"]);

        }
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
