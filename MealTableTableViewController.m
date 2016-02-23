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
    
    
    //we will store all meals in meals array
    Meals = [[NSMutableArray alloc] init];
    
    //we will look up if a meal exist in the database
    mealLookUp = [[NSMutableString alloc] init];
    
    //store the name of the meal clicked so we can look up its ingredients later on
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
    
    //_clickedRestaurant is the clicked restaurant, so lets find meals specific to the chosen restaurant
    [query whereKey:@"Restaurant_Name" equalTo:_clickedRestaurant];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                
                for (int i = 1; i <=9 ; i++){
                
                //find all meals in the table
                mealLookUp = [NSMutableString stringWithFormat:@"Meal%d", i];
                    
                //store all meals found in meals array
                [Meals addObject:[object objectForKey:mealLookUp]];
                    //NSLog(@"Meal Lookup: %@", mealLookUp);
                    //NSLog(@"Meals are: %@", Meals);

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


//one section since we are not sectionalizing this table view controller
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//number of rows are the amount of meals found in the database
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Meals count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    static NSString *restaurantTableIdentifier = @"MealCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
   //display the meals found in the database in each cell
    cell.textLabel.text = [Meals objectAtIndex:indexPath.row];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //we need to the meal the user clicked on so we can lookup its ingredients in the ingredients view controller
    clickedMeal = [Meals objectAtIndex:indexPath.row];
   // NSLog(@"%@", clickedMeal);
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // segue to push name of clicked restaurant to the map controller
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        
        
        //so we could lookup the address of the restaurant clicked, lets pass the name of the restaurant to the map container
        MapContainerViewController *detailViewController = [segue destinationViewController];
        detailViewController.clickedRestaurant2 = _clickedRestaurant;
        
        
        }
    
    //segue to push name of clicked restaurant to the add meals option
    if ([[segue identifier] isEqualToString:@"showMeals"])
    {
        
        

        newMealViewController *detailViewController2 = [segue destinationViewController];
        detailViewController2.clickedRestaurant3 = _clickedRestaurant;
        NSInteger numberOfMeals = [Meals count];
        //lets pass the number of meals, need this for the way we setup our tables in the database
        detailViewController2.numMeals = numberOfMeals;
        
        //lets show the name of the restauarnt clicked as the title of the next view controller
        detailViewController2.title = _clickedRestaurant;

        
        
    }
    
    //clicked meals segue
    if ([[segue identifier] isEqualToString:@"showIngredients"])
    {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        IngredientsTableViewController *detailViewController3 = [segue destinationViewController];
        
        //push info to next view controller
        detailViewController3.clickedMeal2 = [Meals objectAtIndex:indexPath.row];
        
        //get meal index in the list need this to pull up the ingredients
        //needed to look up the ingredients of the meals
        detailViewController3.mealIndex = indexPath.row + 1;
        detailViewController3.title = [Meals objectAtIndex:indexPath.row];
        detailViewController3.clickedRestaurant4 = _clickedRestaurant;
        
    }
    
    
    
}


@end

