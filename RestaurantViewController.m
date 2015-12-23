//
//  RestaurantViewController.m
//  iOS MPM
//
//  Created by Abed Kassem on 11/5/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import "RestaurantViewController.h"
#import "MealTableTableViewController.h"
#import "MapContainerViewController.h"

#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>




@implementation RestaurantViewController

@synthesize sectionToStarts_WithMap = _sectionToStarts_WithMap; //maps sections (0-26) to letters
@synthesize sections = _sections;  //maps letter to starts with to number of objects




- (id)initWithCoder:(NSCoder *)aDecoder
{
    //init with class name
    self = [super initWithClassName:@"Restaurants"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        //init with class name
        self.parseClassName = @"Restaurants";
        
        //set key to restaurant name
        self.textKey = @"Restaurant_Name";
        
        //no pull to refresh, can only refresh with button
        self.pullToRefreshEnabled = NO;
        
        //no pagination, everything is displayed on a single page
        self.paginationEnabled = NO;
        
        //maps letter to objects
        self.sections = [NSMutableDictionary dictionary];
        
        //maps # sections to letters
        self.sectionToStarts_WithMap = [NSMutableDictionary dictionary];
        
        //display all objects on a single page
        self.objectsPerPage = 999999999;

        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //load all objects sorted
    [self loadObjects];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Returns A Number, representing the TOTAL # of sections in our table. The number of sections should grow be 26, since we have 26 letter in the alphabet
   // NSLog(@"%lu", (unsigned long)self.sections.count);
    return self.sections.count;
    
}

- (NSString *)Starts_WithForSection:(NSInteger)section {
    
    //using the section indeces we will find the letter the section represents. This method returns the Starts_With letter string represented by the section
    
    return [_sectionToStarts_WithMap objectForKey:[NSNumber numberWithLong:section]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    NSString *Starts_With = [self Starts_WithForSection:section];
    //NSString *Starts_With = letter returned is set to startwith string
    //NSLog(Starts_With);
    
    
    NSArray *rowIndecesInSection = [self.sections objectForKey:Starts_With];
    //NSArray *rowIndecesInSection = returns number of rows in each section
    //NSLog(@"%@", rowIndecesInSection);
    
    //total number of rows will be the total number of letters (Starts_with) in each section
    return rowIndecesInSection.count;
    
    
}

- (void)objectsDidLoad:(NSError *)error {
    
    
    [super objectsDidLoad:error];
    
    [_sections removeAllObjects];
    
    [_sectionToStarts_WithMap removeAllObjects];
    
    
    //Sorting the objects in the database into sections
    NSInteger section = 0;
    NSInteger rowIndex = 0;
    
    for (PFObject *object in self.objects) {
        
        //set the the starting letter to string Starts_with
        NSString *Starts_With = [object objectForKey:@"Starts_With"];
        
        //store the value @ key Starts_with
        NSMutableArray *objectsInSection = [_sections objectForKey:Starts_With];
        
        if (objectsInSection == nil) {
            
            objectsInSection = [NSMutableArray array];
            
            
            [self.sectionToStarts_WithMap setObject:Starts_With forKey:[NSNumber numberWithLong:section++]];
            //start mapping the section to a starts_with letter 0->A

        }
        //get the total number of objects in each section
        [objectsInSection addObject:[NSNumber numberWithLong:rowIndex++]];
        //map the number of objects in each section to the corresponding letter
        [self.sections setObject:objectsInSection forKey:Starts_With];
        
        /*///////////////////////////
         
         sections to startwith
         0              A
         1              I
         2              W
         
         
         sections
         A              2 objects
         i              1 object
         w              1 object
         
         ///////////////////////////*/

    }

    
}


- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {NSString *Starts_With = [self Starts_WithForSection:indexPath.section];
    
    NSArray *rowIndecesInSection = [_sections objectForKey:Starts_With];
    //number of rows(objects) per section
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    //map the number of objects to each section in the index
    //NSLog(@"%@", rowIndex);
    

    return [self.objects objectAtIndex:[rowIndex intValue]];
    
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    //pull all restaurants from database and order them alphabetically
    [query orderByAscending:@"Restaurant_Name"];
    
    return query;
}


////////////////////////////FORMAT SECTION HEADER///////////////////////////////////
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectNull];
    sectionHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sectionHeader.textAlignment = NSTextAlignmentCenter;
    sectionHeader.font = [UIFont boldSystemFontOfSize:15];
    sectionHeader.textColor = [UIColor blackColor];
    sectionHeader.text = [self Starts_WithForSection:section];

    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 20;
}
////////////////////////////FORMAT SECTION HEADER///////////////////////////////////



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"RootCell";

    PFTableViewCell *cell = (PFTableViewCell *)[tableView   dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault    reuseIdentifier:CellIdentifier];

    }
    //Set the cell to each restaurant name
    cell.textLabel.text = [object objectForKey:@"Restaurant_Name"];
    
    
    
    
    return cell;
}



///////////////////////////////A-Z INDEX BAR/////////////////////////////////////////////
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSArray *sections = [_sections allKeys];
    NSArray *sorted = [sections sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return sorted;
}
///////////////////////////////A-Z INDEX BAR/////////////////////////////////////////////



//REFRESH BUTTON
- (IBAction)refreshBTN:(id)sender {
    //reload restaurant table
    
    [self loadObjects];
    
}



////////////////////////////////SEGUE SETTINGS/////////////////////////////////////////////
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *Starts_With = [self Starts_WithForSection:indexPath.section];

        NSArray *rowIndecesInSection = [self.sections objectForKey:Starts_With];

        NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];

        //NSLog(@"%@", rowIndex);
        
        PFObject *object = [self.objects objectAtIndex:[rowIndex intValue]];
        
        MealTableTableViewController *detailViewController = [segue destinationViewController];
       
        detailViewController.clickedRestaurant = [object objectForKey:@"Restaurant_Name"];
        
        NSString *RestaurantMenuTitle = [NSString stringWithFormat:@"%@'s Menu",[object objectForKey:@"Restaurant_Name"]];
        detailViewController.title = RestaurantMenuTitle;
        


        //if you need to pass data to the next controller do it here
    }
}
////////////////////////////////SEGUE SETTINGS/////////////////////////////////////////////

@end