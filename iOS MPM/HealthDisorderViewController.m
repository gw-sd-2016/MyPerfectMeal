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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user selects something
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else{
        //user deselects something
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
}



@end