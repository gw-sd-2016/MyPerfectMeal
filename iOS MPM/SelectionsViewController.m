//
//  SelectionsViewController.m
//  iOS MPM
//
//  Created by guest on 2/23/16.
//  Copyright © 2016 Abed Kassem. All rights reserved.
//

#import "SelectionsViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface SelectionsViewController ()

@end

@implementation SelectionsViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"User";
        
        self.pullToRefreshEnabled = YES;
        
        self.paginationEnabled = NO;
        
        self.objectsPerPage = 999999999;
        
        findSelections = [[NSMutableArray alloc] init];
        
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
    
    NSString *selectedGoals = [[NSString alloc] init];
    NSArray *selectedMeds = [[NSArray alloc] init];
    NSArray *selectedFoodAllergy = [[NSArray alloc] init];
    NSArray *selectedDisorder = [[NSArray alloc] init];

    selectedGoals = [[PFUser currentUser] objectForKey:@"selectedGoal"];
    selectedMeds = [[PFUser currentUser] objectForKey:@"selectedMeds"];
    selectedFoodAllergy = [[PFUser currentUser] objectForKey:@"selectedFoodAllergy"];
    selectedDisorder = [[PFUser currentUser] objectForKey:@"selectedDisorder"];
    
    if (selectedGoals != nil){
        [findSelections addObject:selectedGoals];
    }
    
    if (selectedMeds != nil){
        [findSelections addObjectsFromArray:selectedMeds];
    }
    
    if (selectedFoodAllergy != nil){
        [findSelections addObjectsFromArray:selectedFoodAllergy];
    }
    
    if (selectedDisorder != nil){
        [findSelections addObjectsFromArray:selectedDisorder];
    }
    
    //NSLog(@"The user selections are %@", findSelections);
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//not sectionalized so 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//rows as many as goals pulled from database
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [findSelections count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *goalsTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:goalsTableIdentifier];
    
    cell.textLabel.text = [findSelections objectAtIndex:indexPath.row];
    
    
    return cell;
}

@end