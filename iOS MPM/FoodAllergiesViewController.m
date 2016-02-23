//
//  FoodAllergiesViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 12/1/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "FoodAllergiesViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface FoodAllergiesViewController ()

@end

@implementation FoodAllergiesViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"foodAllergies";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        
        foodAllergies = [[NSMutableArray alloc] init];
        selectedAllergies = [[NSMutableArray alloc] init];
        findSelectedAllergies = [[NSMutableString alloc] init];
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}

-(void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //querry to load all objects into the food allergies array we created
    PFQuery *query = [PFQuery queryWithClassName:@"foodAllergies"];
    [query setLimit: 1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                
                
                [foodAllergies addObject:[object objectForKey:@"foodAllergen"]];
                [self loadObjects];
            }
            
        }
        
        findSelectedAllergies = [[PFUser currentUser] valueForKey:@"selectedFoodAllergy"];

        
        
    }];
    
    [self loadObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//one section since no sectionalizing is going on
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //number of rows same as number of elements in food allergies
    return [foodAllergies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *restaurantTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    //assign the text to each cell for each element in the array
    cell.textLabel.text = [foodAllergies objectAtIndex:indexPath.row];
    
    if ([findSelectedAllergies containsObject:[foodAllergies objectAtIndex:indexPath.row]  ]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user selects something
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        //check the cell selected
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //if its already in the array to send to the server do nothing
        if ([selectedAllergies containsObject:cell.textLabel.text]){
            //ignore before its already in the database
        }
        else{
            //otherwise its not so add it to the array
            [selectedAllergies addObject:cell.textLabel.text];
            //send off the data to parse and save
            [[PFUser currentUser] setObject:selectedAllergies forKey:@"selectedFoodAllergy"];
            [[PFUser currentUser] saveInBackground];
        }
        
    }else{
        //user deselects something so they want to remove it
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedAllergies removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] setObject:selectedAllergies forKey:@"selectedFoodAllergy"];
        [[PFUser currentUser] saveInBackground];
        
        
        
    }
}




@end