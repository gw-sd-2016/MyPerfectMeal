
#import "MenuTableViewController.h"
#import "MapContainerViewController.h"
#import "MealIngredientsViewController.h"
#import "RestaurantsTableViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController


-(NSString *) loadRawHTML{
    
    //NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://www.allmenus.com/dc/washington/18286-the-pita-pit/menu/"];
     //NSMutableString *restaurantDirectoryURLString = [NSMutableString stringWithFormat:@"http://www.allmenus.com/dc/washington-dc/360167-fobogro/menu/"];
    //NSMutableString *restaurantDirectoryURLString = [NSMutableString stringWithFormat:@"http://www.allmenus.com/dc/washington/437291-char-bar/menu/"];
    //NSMutableString *restaurantDirectoryURLString = [NSMutableString stringWithFormat:@"http://www.allmenus.com/dc/washington/373615-the-deli/menu/"];
    //NSLog(@"%@", _clickedRestaurantURL);
    NSDate *methodStart = [NSDate date];


    NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://www.allmenus.com%@", _clickedRestaurantURL];
    
    NSLog(@"Navigating to %@", restaurantDirectoryURLString);

    
    NSURL *restaurantDirectoryURL = [[NSURL alloc] initWithString:restaurantDirectoryURLString];
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:restaurantDirectoryURL];
    
    NSScanner *getHTMLScanner;
    NSString *loadHTMLPage = @"";
    getHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([getHTMLScanner isAtEnd] == NO) {
        
        [getHTMLScanner scanUpToString:@"<div id=\"menu\"" intoString:NULL] ;
        [getHTMLScanner scanUpToString:@"<!-- foreach menu -->" intoString:&loadHTMLPage] ;
        
        
    }
    NSDate *methodFinish = [NSDate date];
    NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
    NSLog(@"executionTime = %f", executionTime);

    
    
    NSLog(@"Loaded Raw Html For A Specific Restaurant");
    
    //NSLog(@"%@", loadHTMLPage);
    
    
    return loadHTMLPage;
    
}




-(NSMutableArray *) getCategoryNames{
    
    NSScanner *getCategoriesScanner;
    NSString *getCategories = nil;
    NSMutableArray  *getCategoriesArray = [[NSMutableArray alloc] init];
    
    getCategoriesScanner = [NSScanner scannerWithString:loadedRawHTML];
    
    while ([getCategoriesScanner isAtEnd] == NO) {
        
        
        [getCategoriesScanner scanUpToString:@"<h3>" intoString:NULL] ;
        
        [getCategoriesScanner scanUpToString:@"</h3>" intoString:&getCategories] ;
        
        getCategories = [getCategories stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<h3>"] withString:@""];

        
        if ([getCategoriesArray containsObject:getCategories]){

        }
        else{
            [getCategoriesArray addObject:getCategories];

        }
        
        
        
    }
    
    //[getCategoriesArray removeLastObject];
    [getCategoriesArray addObject:@"<!-- foreach menu -->"];
    
   // NSLog(@"%@", getCategoriesArray);
    
    return getCategoriesArray;
}




-(NSString *) loadCatHTML: (int) Y{
    
    
    NSScanner *getHTMLScanner;
    NSString *secondHTML = @"";
    getHTMLScanner = [NSScanner scannerWithString:loadedRawHTML];
    
    NSString *firstCat = [NSString stringWithFormat:@"<h3>%@</h3>", [self getCategoryNames][Y]];
    NSString *secondCat = [NSString stringWithFormat:@"<h3>%@</h3>", [self getCategoryNames][Y+1]];

    
    while ([getHTMLScanner isAtEnd] == NO) {
        
        
        [getHTMLScanner scanUpToString:firstCat intoString:NULL] ;
        [getHTMLScanner scanUpToString:secondCat intoString:&secondHTML] ;
        
        
    }
    

    
    return secondHTML;
    
}
 



-(NSMutableArray *) getMealNames: (int) X{
    
    NSScanner *getMealNamesScanner;
    NSString *getMeals = nil;
    NSString *loadCatHTMLString = [self loadCatHTML:X];
    getMealNamesScanner = [NSScanner scannerWithString:loadCatHTMLString];
    NSMutableArray  *getMealNamesArray = [[NSMutableArray alloc] init];
    
    while ([getMealNamesScanner isAtEnd] == NO) {
        
        
        [getMealNamesScanner scanUpToString:@"<span class=\"name\">" intoString:NULL] ;
        [getMealNamesScanner scanUpToString:@"</span>" intoString:&getMeals] ;
        
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<span class=\"name\">"] withString:@""];
        
        
        [getMealNamesArray addObject:getMeals];
        
        
        
    }
    
    [getMealNamesArray removeLastObject];
    
    return getMealNamesArray;
    
    
    
}



/*
-(NSMutableArray *) getMealPricing{
    
    NSScanner *getMealPricesScanner;
    NSString *getPrices = nil;
    getMealPricesScanner = [NSScanner scannerWithString:loadedRawHTML];
    NSMutableArray *getPricesArray = [[NSMutableArray alloc] init];
    while ([getMealPricesScanner isAtEnd] == NO) {
        
        
        [getMealPricesScanner scanUpToString:@"<p>$" intoString:NULL] ;
        
        [getMealPricesScanner scanUpToString:@"</p>" intoString:&getPrices] ;
        
        getPrices = [getPrices stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p>"] withString:@""];
        getPrices = [getPrices stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"amp;"] withString:@""];
        
        // getPrices = [getPrices stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" "] withString:@""];
        
        
        //NSLog(@"%@", getPrices);
        [getPricesArray addObject:getPrices];
        
        
    }
    
    [getPricesArray removeLastObject];
    
    return getPricesArray;
    
}

*/



-(NSString *) getIngredients: (NSString *) mealName{
    
    
    NSMutableString *scannerBeginingString = [[NSMutableString alloc] initWithFormat:@"<span class=\"name\">%@</span>", mealName];
    
    NSScanner *getIngredientsScanner;
    NSString *getIngredients = nil;
    getIngredientsScanner = [NSScanner scannerWithString:loadedRawHTML];
    
    while ([getIngredientsScanner isAtEnd] == NO) {
        
        
        
        [getIngredientsScanner scanUpToString:scannerBeginingString intoString:NULL] ;
        [getIngredientsScanner scanUpToString:@"</p>" intoString:&getIngredients] ;
        
        
        //[getIngredientsScanner scanUpToString:@"<dd>" intoString:NULL] ;
        
        //[getIngredientsScanner scanUpToString:@"</dd>" intoString:&getIngredients] ;
        
        
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:scannerBeginingString] withString:@""];
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"description\">"] withString:@""];
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"  "] withString:@""];
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" <span class=\"price\">"] withString:@""];
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</span>"] withString:@" "];


        getIngredients = [[getIngredients componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];

        
        
    }
    
    
    return getIngredients;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = _clickedRestaurantName;
    

    loadedRawHTML = [self loadRawHTML];

    
    NSArray *saveGetCategoryNames = [[NSArray alloc] initWithArray:[self getCategoryNames]];
    
    //NSLog(@"%@", saveGetCategoryNames);
    
    if ([saveGetCategoryNames count] <= 1) {
        NSLog(@"WEBSITE DOES NOT EXIST");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        NSMutableArray *saveGetMealNames = [[NSMutableArray alloc ] init];
        
        Meals = [[NSMutableDictionary alloc]initWithCapacity:[[self getCategoryNames] count]];
        
        
        for (int i = 0; i <= ([[self getCategoryNames] count] - 2); i++){
            
            
            
            [saveGetMealNames addObject:[self getMealNames:i]];
            
            
            
            [Meals setObject:saveGetMealNames[i] forKey:saveGetCategoryNames[i]];
            
            
            
        }
        
        
        MealSectionTitles = [[Meals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        
        
        
        allMealsAsSeen = [[NSMutableArray alloc] init];
        
        
        for (int i = 0; i <= [[Meals allKeys]count]-1; i++){
            
            for (int j = 0; j <= [[Meals allValues][i] count]-1; j++){
               // NSLog(@"%@", [Meals allValues][i][j]);
                [allMealsAsSeen addObject:[Meals allValues][i][j]];
            }
            
            
        }
       
        

                
        subtitleDict = [[NSMutableDictionary alloc]initWithCapacity:[allMealsAsSeen count]];
        
        //NSLog(@"%i", [[self getAllIngredientsFound] count]);
       
        
        for (int i = 0; i <= [allMealsAsSeen count]-1; i++){
            
            [subtitleDict setObject:[self getAllIngredientsFound][i] forKey:allMealsAsSeen[i]];
            NSLog(@"%i out of %lu", i, (unsigned long)[allMealsAsSeen count]);
            
        }
        

        
    }
    

   
    
}


-(NSMutableArray *) getAllIngredientsFound{
    
    
    NSMutableArray *allIngredeientsFoundArray = [[NSMutableArray alloc ] init];
    
    //NSLog(@"start printing ingredients");
    for (int i = 0; i <= allMealsAsSeen.count-1; i++) {
        //NSLog(@"%@", [self getIngredients:allMealsAsSeen[i]]);
        [allIngredeientsFoundArray addObject:[self getIngredients:allMealsAsSeen[i]]];
    }
    
    return allIngredeientsFoundArray;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [MealSectionTitles count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    NSString *sectionTitle = [MealSectionTitles objectAtIndex:section];
    NSArray *sectionMeals = [Meals objectForKey:sectionTitle];
    return [sectionMeals count];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [MealSectionTitles objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    NSString *sectionTitle = [MealSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionMeals = [Meals objectForKey:sectionTitle];
    NSString *Meal = [sectionMeals objectAtIndex:indexPath.row];
    
    cell.textLabel.text = Meal;
    
    
    NSString *subtitleOfMeal = [subtitleDict valueForKey:Meal];
    
    cell.detailTextLabel.text = subtitleOfMeal;
    
    //cell.detailTextLabel.text = [[self getAllIngredientsFound] objectAtIndex:indexPath.row];
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *sectionTitle = [MealSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionMeals = [Meals objectForKey:sectionTitle];
    clickedMealString = [sectionMeals objectAtIndex:indexPath.row];
    
    clickedMealIngredientsString = [subtitleDict valueForKey:clickedMealString];
    
    
    [self performSegueWithIdentifier:@"showIngredients" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // segue to push name of clicked restaurant to the map controller
    if ([[segue identifier] isEqualToString:@"showMap"])
    {
        
        
        MapContainerViewController *MapDetailsViewController = [segue destinationViewController];
        
        MapDetailsViewController.clickedRestaurantNameInMap = _clickedRestaurantName;
        MapDetailsViewController.clickedRestaurantAddressInMap = _clickedRestaurantAddress;
        
        //NSLog(@"%@", MapDetailsViewController.clickedRestaurantNameInMap);
        //NSLog(@"%@", MapDetailsViewController.clickedRestaurantAddressInMap);
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"showIngredients"])
    {
        
        MealIngredientsViewController *showIngredientsViewController = [segue destinationViewController];
        showIngredientsViewController.clickedMealName = clickedMealString;
        showIngredientsViewController.clickedMealIngredeients = clickedMealIngredientsString;
        
        
        
        
    }
}



@end
