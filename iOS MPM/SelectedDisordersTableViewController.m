//
//  SelectedDisordersTableViewController.m
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "SelectedDisordersTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface SelectedDisordersTableViewController ()

@end

@implementation SelectedDisordersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HealthDisorders = [[NSMutableArray alloc] initWithObjects:
                       @"Heart disease",
                       @"High Blood Pressure",
                       @"High Cholesterol",
                       @"Obese",
                       @"Asthma",
                       @"Diabetes",
                       @"Frequent Headaches",
                       @"Depression",
                       @"Anxiety",
                       @"Gastrointestinal Problems",
                       @"Alzheimer's Disease", nil];
    selectedDisorders = [[NSMutableArray alloc] init];
    findSelectedDisorders = [[NSMutableArray alloc] init];
    findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [HealthDisorders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [HealthDisorders objectAtIndex:indexPath.row];
    
    
    
    if ( [findSelectedDisorders containsObject:[HealthDisorders objectAtIndex:indexPath.row]] ){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[PFUser currentUser] saveInBackground];
        findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[PFUser currentUser] saveInBackground];
        findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user makes new selection
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        //check the cell selected
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedDisorders addObject:cell.textLabel.text];
        [[PFUser currentUser] setObject:selectedDisorders forKey:@"selectedDisorder"];
        [[PFUser currentUser] saveInBackground];
        findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];
        
        
    }else{
        //user user selects something already pressed
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedDisorders removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] removeObject:cell.textLabel.text forKey:@"selectedDisorder"];
        [[PFUser currentUser] saveInBackground];
        findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];
        
    }
}





@end
