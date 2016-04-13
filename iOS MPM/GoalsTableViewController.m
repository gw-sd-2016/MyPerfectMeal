//
//  GoalsTableViewController.m
//  iOS MPM
//
//  Created by guest on 4/12/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "GoalsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>


@interface GoalsTableViewController ()

@end

@implementation GoalsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    healthGoals = [[NSMutableArray alloc] init];
    findSelectedGoal = [[NSMutableString alloc] init];

    healthGoals = [[NSMutableArray alloc] initWithObjects:@"No Weight Goals",@"Gain Weight", @"Lose Weight", @"Maintain Current Weight", nil];
    
    findSelectedGoal = [[PFUser currentUser] valueForKey:@"selectedGoal"];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [healthGoals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [healthGoals objectAtIndex:indexPath.row];
    
    //find the cell that matches what was found in the server and check mark it
    if ([[healthGoals objectAtIndex:indexPath.row] isEqualToString:findSelectedGoal ]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user selects a goal @ indexpath
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [[PFUser currentUser] setObject:cell.textLabel.text forKey:@"selectedGoal"];
    [[PFUser currentUser] saveInBackground];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}



@end
