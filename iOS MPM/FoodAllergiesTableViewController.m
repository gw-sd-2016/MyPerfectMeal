//
//  FoodAllergiesTableViewController.m
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "FoodAllergiesTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface FoodAllergiesTableViewController ()

@end

@implementation FoodAllergiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    
    foodAllergies = [[NSMutableArray alloc] initWithObjects:@"Nuts", @"Fish", @"Shellfish", @"Milk", @"Egg", @"Soy", @"Wheat", nil];
    selectedAllergies = [[NSMutableArray alloc] init];
    findSelectedAllergies = [[NSMutableArray alloc] init];
    
    findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [foodAllergies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

    cell.textLabel.text = [foodAllergies objectAtIndex:indexPath.row];
    
    
    
    if ( [findSelectedAllergies containsObject:[foodAllergies objectAtIndex:indexPath.row]] ){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[PFUser currentUser] saveInBackground];
        findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[PFUser currentUser] saveInBackground];
        findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];
    }

    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user makes new selection
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        //check the cell selected
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedAllergies addObject:cell.textLabel.text];
        [[PFUser currentUser] setObject:selectedAllergies forKey:@"selectedFoodAllergy"];
        [[PFUser currentUser] saveInBackground];
        findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];
        
        
    }else{
        //user user selects something already pressed
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedAllergies removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] removeObject:cell.textLabel.text forKey:@"selectedFoodAllergy"];
        [[PFUser currentUser] saveInBackground];
        findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];
        
    }
}




@end
