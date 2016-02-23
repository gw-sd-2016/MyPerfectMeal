//
//  MedicationsViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 12/1/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "MedicationsViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MedicationsViewController ()

@end

@implementation MedicationsViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        
        self.parseClassName = @"Medications";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;

        
        Medications = [[NSMutableArray alloc] init];
        selectedMeds = [[NSMutableArray alloc] init];
        findSelectedMeds = [[NSMutableString alloc] init];
        
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
    
    //query everything in class medications
    PFQuery *query = [PFQuery queryWithClassName:@"Medications"];
    [query setLimit: 1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
               
                //store all objects (medication names) into the medications array
                    [Medications addObject:[object objectForKey:@"medName"]];
                    [self loadObjects];
                }
                
            }
            
        findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];

        
        
    }];
    
    [self loadObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//not sectionalized so 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//rows as many as medications pulled from database
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Medications count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    static NSString *restaurantTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    //cell label is same as each element in the array
    cell.textLabel.text = [Medications objectAtIndex:indexPath.row];
    
    if ([findSelectedMeds containsObject:[Medications objectAtIndex:indexPath.row]  ]){
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
        if ([selectedMeds containsObject:cell.textLabel.text]){
            //ignore before its already in the database
        }
        else{
            //otherwise its not so add it to the array
            [selectedMeds addObject:cell.textLabel.text];
            //send off the data to parse and save
            [[PFUser currentUser] setObject:selectedMeds forKey:@"selectedMeds"];
            [[PFUser currentUser] saveInBackground];
        }
        
    }else{
        //user deselects something so they want to remove it
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedMeds removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] setObject:selectedMeds forKey:@"selectedMeds"];
        [[PFUser currentUser] saveInBackground];
        
        
}
}



@end