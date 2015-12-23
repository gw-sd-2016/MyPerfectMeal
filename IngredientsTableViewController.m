//
//  IngredientsTableViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/22/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import "newIngViewController.h"
#import "IngredientsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController

@synthesize clickedRestaurant4, clickedMeal2, mealIndex;


- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.parseClassName = @"Restaurants";
        
        
        self.pullToRefreshEnabled = YES;
        
        
        self.paginationEnabled = YES;
        
        
        
        Ingredients = [[NSMutableArray alloc] init];
        ingLookUp = [[NSMutableString alloc] init];
        
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@", clickedRestaurant4);
    //NSLog(@"%@", clickedMeal2);
    // NSLog(@"%d", mealIndex);
    
    NSString *clickedMealFormation = [NSString stringWithFormat:@"Meal%ld", (long)mealIndex];
    //NSLog(@"%@", clickedMealFormation);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:clickedRestaurant4];
    [query whereKey:clickedMealFormation equalTo:clickedMeal2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                //NSLog(@"%@", objects);
                
                
                for (int i = 0; i <=9 ; i++){
                    ingLookUp = [NSMutableString stringWithFormat:@"Ing%ld%d", (long)mealIndex, i];
                     NSLog(@"%@", ingLookUp);
                    
                    if (object[ingLookUp]) {
                        //NSLog(@"FOUND SOMETHING AT %@", ingLookUp);
                        [Ingredients addObject:[object objectForKey:ingLookUp]];
                        // NSLog(@"FOUND %@ AT %@",[object objectForKey:ingLookUp] ,  ingLookUp);
                        
                        //NSLog(@"%@", Ingredients);
                        [self loadObjects];
                        
                    }
                    else{
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }];
    
    
    
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
    return [Ingredients count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *restaurantTableIdentifier = @"ingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:restaurantTableIdentifier];
    
    
    cell.textLabel.text = [Ingredients objectAtIndex:indexPath.row];
    return cell;
}



-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // NSLog(@"%@", indexPath);
    
    NSString *ingToDelete = [Ingredients objectAtIndex:indexPath.row];
    NSString *clickedMealFormation = [NSString stringWithFormat:@"Meal%ld", (long)mealIndex];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurants"];
    [query whereKey:@"Restaurant_Name" equalTo:clickedRestaurant4];
    [query whereKey:clickedMealFormation equalTo:clickedMeal2];
    
    
    //NSLog(@"location of ingredient to delete in the database is: %@", clickedIngredientFormation);
    
    // PFObject *object = [self.objects objectAtIndex:[Ingredients objectAtIndex:indexPath.row]];
    // NSLog(@"%@", object);
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                
                //NSLog(@"%@", objects);
                
                
                for (int i = 0; i <=9 ; i++){
                    ingLookUp = [NSMutableString stringWithFormat:@"Ing%ld%d", (long)mealIndex, i];
                    // NSLog(@"%@", ingLookUp);
                    
                    if (object[ingLookUp]) {
                        //NSLog(@"FOUND SOMETHING AT %@", ingLookUp);
                        [Ingredients addObject:[object objectForKey:ingLookUp]];
                        //NSLog(@"FOUND %@ AT %@",[object objectForKey:ingLookUp] ,  ingLookUp);
                        
                        if ([ingToDelete isEqualToString:[object objectForKey:ingLookUp]]){
                            
                            NSLog(@"we want to delete %@ and its %@ AT %@", ingToDelete, [object objectForKey:ingLookUp], ingLookUp);
                            [object removeObjectForKey:ingLookUp];
                            [object saveInBackground];
                            [self loadObjects];
                            
                        }
                        
                        
                        //NSLog(@"%@", Ingredients);
                        [self loadObjects];
                        
                    }
                    else{
                        
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }];
    
    
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // segue to push name of clicked restaurant to the map controller
    if ([[segue identifier] isEqualToString:@"addIngredients"])
    {
        NSString *clickedMealFormation = [NSString stringWithFormat:@"Meal%ld", (long)mealIndex];
        NSInteger clickedMealNumber = mealIndex;
        
        newIngViewController *detailViewController = [segue destinationViewController];
        detailViewController.ingMealIndex = clickedMealFormation;
        detailViewController.ingMealIndexNumber = clickedMealNumber;
        detailViewController.clickedRestaurant5 = clickedRestaurant4;
        detailViewController.title = clickedMealFormation;
        
    }
}
@end