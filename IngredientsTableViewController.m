//
//  IngredientsTableViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/22/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController

@synthesize clickedRestaurant4, clickedMeal2, mealIndex;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithClassName:@"Restaurants"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"Restaurants";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = YES;
        
        
        self.objectsPerPage = 999999999;
        
        
        
    }
    
    
   
    
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@", clickedRestaurant4);
    //NSLog(@"%@", clickedMeal2);
    //NSLog(@"%d", mealIndex);

    NSString *clickedMealFormation = [NSString stringWithFormat:@"Meal%d", mealIndex];
    //NSLog(@"%@", clickedMealFormation);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:clickedRestaurant4];
    [query whereKey:clickedMealFormation equalTo:clickedMeal2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
               
                NSLog(@"%@", objects);
                
                /*
                for (int i = 1; i <=9 ; i++){
                    
                    mealLookUp = [NSMutableString stringWithFormat:@"Meal%d", i];
                    [Meals addObject:[object objectForKey:mealLookUp]];
                    
                }
                */
            }
            
            
        }
        
    }];
    
    [self loadObjects];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *restaurantTableIdentifier = @"ingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    
    
    
    return cell;
}

@end
