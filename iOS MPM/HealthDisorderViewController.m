//
//  HealthDisorderViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 12/2/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "HealthDisorderViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>


@interface HealthDisorderViewController ()

@end

@implementation HealthDisorderViewController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"healthDisorders";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        
        HealthDisorders = [[NSMutableArray alloc] init];
        selectedDisorders = [[NSMutableArray alloc] init];
        findSelectedDisorders = [[NSMutableString alloc] init];


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
    
    //load all disorders and store them in an array
    
    PFQuery *query = [PFQuery queryWithClassName:@"healthDisorders"];
    [query setLimit: 1000];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                
                
                [HealthDisorders addObject:[object objectForKey:@"HDName"]];
                //NSLog(@"Disorder name in parse is: %@", HealthDisorders);
                [self loadObjects];
            }
            
        }
        
        //pull the previously selected disorders from parse and save them into findSelectedDisorders array
        findSelectedDisorders = [[PFUser currentUser] valueForKey:@"selectedDisorder"];
        
        
    }];
    
    [self loadObjects];
    
}

-(void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//one section since no sectionalizing going on
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//number of rows same as number of elements in the array
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [HealthDisorders count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *restaurantTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];

    //set text of cell to each element
    cell.textLabel.text = [HealthDisorders objectAtIndex:indexPath.row];
    
    if ([findSelectedDisorders containsObject:[HealthDisorders objectAtIndex:indexPath.row]  ]){
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
        if ([selectedDisorders containsObject:cell.textLabel.text]){
            //ignore before its already in the database
        }
        else{
            //otherwise its not so add it to the array
            [selectedDisorders addObject:cell.textLabel.text];
            //send off the data to parse and save
            [[PFUser currentUser] setObject:selectedDisorders forKey:@"selectedDisorder"];
            [[PFUser currentUser] saveInBackground];
        }
        
    }else{
        //user deselects something so they want to remove it
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedDisorders removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] setObject:selectedDisorders forKey:@"selectedDisorder"];
        [[PFUser currentUser] saveInBackground];

        
        
    }
   
}



@end