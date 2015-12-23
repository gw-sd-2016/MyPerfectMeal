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
        
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
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
                //NSLog(@"Allergen name in parse is: %@", foodAllergies);
                [self loadObjects];
            }
            
        }
        
        
        
        
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //PFUser *currentUser = [PFUser currentUser];
   /*
    [currentUser removeObjectForKey:@"CheckedItem0"];
    [currentUser removeObjectForKey:@"CheckedItem1"];
    [currentUser removeObjectForKey:@"CheckedItem2"];
    [currentUser removeObjectForKey:@"CheckedItem3"];
    [currentUser removeObjectForKey:@"CheckedItem4"];
    [currentUser removeObjectForKey:@"CheckedItem5"];
    [currentUser removeObjectForKey:@"CheckedItem6"];
    [currentUser removeObjectForKey:@"CheckedItem7"];

   */
    //if user selects row
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //NSLog(@"We just checked: %@", [foodAllergies objectAtIndex:indexPath.row]);
    
        /*
        //find empty slot in table
    
        PFQuery *query = [PFUser query];;
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                for (PFObject *object in objects) {
                    
                    NSString *emptySlotLookUp = [[NSString alloc] init];
                    
                    
                    for (int i = 0; i <=10 ; i++){
                        
                        emptySlotLookUp = [NSMutableString stringWithFormat:@"CheckedItem%d", i];
                        
                        if (object[emptySlotLookUp]) {
                            //do nothing
                        }
                        else{
                            //  if (object[emptySlotLookUp]) { NSLog(@"FOUND SOMETHING AT %@", emptySlotLookUp);
                            // if !object @ empty slotlookup that means we found an empty slot insert the selection @key of empty slot
                            [currentUser setObject:[foodAllergies objectAtIndex:indexPath.row] forKey:emptySlotLookUp];
                            [currentUser save];
                            break;
                            
                        }

                    }
                    
                }
                
               
            }
            
        }];
        
        */

        
        
        
        
        
        
        //add checked to table for current user
        
                
                
           
       
            
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        //NSLog(@"We just unchecked: %@", [foodAllergies objectAtIndex:indexPath.row] );
        
        //remove uncheked from database for current user
        
            /*
                
                
                [currentUser removeObjectForKey:@"CheckedItem0"];
                [currentUser save];
        
        */

            
        
        
    }
}




@end