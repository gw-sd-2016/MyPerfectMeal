//
//  MealTableTableViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/13/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "RestaurantViewController.h"
#import "MealTableTableViewController.h"
#import "MapContainerViewController.h"
#import "newMealViewController.h"
#import "IngredientsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MealTableTableViewController ()


@end

@implementation MealTableTableViewController
//
//  RestaurantViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/5/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.

//
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
    
    Meals = [[NSMutableArray alloc] init];
    mealLookUp = [[NSMutableString alloc] init];
    clickedMeal = [[NSString alloc] init];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}


- (void)viewDidLoad {
    //print clicked on restaurant
    
    
    //NSLog(@"%@",_clickedRestaurant);

    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:_clickedRestaurant];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                for (int i = 1; i <=9 ; i++){
                    
                mealLookUp = [NSMutableString stringWithFormat:@"Meal%d", i];
                [Meals addObject:[object objectForKey:mealLookUp]];

                }

        }
            

    }
        
    }];
 
    [self loadObjects];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *restaurantTableIdentifier = @"MealCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
   
    cell.textLabel.text = [Meals objectAtIndex:indexPath.row];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    clickedMeal = [Meals objectAtIndex:indexPath.row];
   // NSLog(@"%@", clickedMeal);
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // segue to push name of clicked restaurant to the map controller
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        
        

        MapContainerViewController *detailViewController = [segue destinationViewController];
        detailViewController.clickedRestaurant2 = _clickedRestaurant;
        
        
        }
    
    //segue to push name of clicked restaurant to the add meals option
    if ([[segue identifier] isEqualToString:@"showMeals"])
    {
        
        

        newMealViewController *detailViewController2 = [segue destinationViewController];
        detailViewController2.clickedRestaurant3 = _clickedRestaurant;
        NSInteger numberOfMeals = [Meals count];
        detailViewController2.numMeals = numberOfMeals;
        detailViewController2.title = _clickedRestaurant;

        
        
    }
    
    //clicked meals segue
    if ([[segue identifier] isEqualToString:@"showIngredients"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        IngredientsTableViewController *detailViewController3 = [segue destinationViewController];
        
        detailViewController3.clickedMeal2 = [Meals objectAtIndex:indexPath.row];
        
        //get meal index in the list need this to pull up the ingredients
        detailViewController3.mealIndex = indexPath.row + 1;
        detailViewController3.title = [Meals objectAtIndex:indexPath.row];
        detailViewController3.clickedRestaurant4 = _clickedRestaurant;
        
    }
    
    
    
}


@end

