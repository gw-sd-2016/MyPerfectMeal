
#import "MenuTableViewController.h"
#import "MapContainerViewController.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController


-(NSString *) loadRawHTML{

    
    //NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com/dc/washington/239197-potbelly-sandwich-works/amp/"];
    
    //self.title = _clickedRestaurantName;
    
    //NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com/dc/washington/437291-char-bar/amp/"];
    //NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com%@", _clickedRestaurantURL];
    
    NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com/dc/washington-dc/360167-fobogro/menu/"];
    
    NSURL *restaurantDirectoryURL = [[NSURL alloc] initWithString:restaurantDirectoryURLString];
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:restaurantDirectoryURL];
    
    NSScanner *getHTMLScanner;
    NSString *loadHTMLPage = @"";
    getHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([getHTMLScanner isAtEnd] == NO) {
        
        [getHTMLScanner scanUpToString:@"<div id=\"menu\"" intoString:NULL] ;
        [getHTMLScanner scanUpToString:@"<!-- alternative menus -->" intoString:&loadHTMLPage] ;
        
        
    }
    
    return loadHTMLPage;
    
}


-(NSMutableArray *) getCategoryNames{
    
    NSScanner *getCategoriesScanner;
    NSString *getCategories = nil;
    NSMutableArray  *getCategoriesArray = [[NSMutableArray alloc] init];
    
    getCategoriesScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    
    while ([getCategoriesScanner isAtEnd] == NO) {
        
        
        [getCategoriesScanner scanUpToString:@"<h3>" intoString:NULL] ;
        
        [getCategoriesScanner scanUpToString:@"</h3>" intoString:&getCategories] ;
        
        getCategories = [getCategories stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<h3>"] withString:@""];
        // getCategories = [getCategories stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"amp;"] withString:@""];
        
        
        [getCategoriesArray addObject:getCategories];
        
        
        
    }
    
    [getCategoriesArray removeLastObject];
    [getCategoriesArray addObject:@"<!-- alternative menus -->"];
    
    return getCategoriesArray;
}


-(NSString *) loadCatHTML: (int) Y{
    
    
    NSScanner *getHTMLScanner;
    NSString *secondHTML = @"";
    getHTMLScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    //NSLog(@"%@ and %@", [self getCategoryNames][Y],[self getCategoryNames][Y+1]);
    
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
    getMealNamesScanner = [NSScanner scannerWithString:[self loadCatHTML:X]];
    NSMutableArray  *getMealNamesArray = [[NSMutableArray alloc] init];
    
    while ([getMealNamesScanner isAtEnd] == NO) {
        
        
        [getMealNamesScanner scanUpToString:@"<dt>" intoString:NULL] ;
        [getMealNamesScanner scanUpToString:@"<p>" intoString:&getMeals] ;
        
        //[getMealNamesScanner scanUpToString:@"</dt>" intoString:&getMeals] ;
        
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<dt>"] withString:@""];
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"amp;"] withString:@""];
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p>"] withString:@"   "];
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</p>"] withString:@""];
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"ñ"] withString:@"n"];
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"'"] withString:@"'"];
        
        
        
        
        
        
        [getMealNamesArray addObject:getMeals];
        
        
    }
    
    [getMealNamesArray removeLastObject];
    
    return getMealNamesArray;
    
    
    
}


-(NSMutableArray *) getMealPricing{
    
    NSScanner *getMealPricesScanner;
    NSString *getPrices = nil;
    getMealPricesScanner = [NSScanner scannerWithString:[self loadRawHTML]];
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

-(NSMutableArray *) getIngredients{
    
    NSScanner *getIngredientsScanner;
    NSString *getIngredients = nil;
    getIngredientsScanner = [NSScanner scannerWithString:[self loadRawHTML]];
    NSMutableArray *getIngredientsArray = [[NSMutableArray alloc] init];
    while ([getIngredientsScanner isAtEnd] == NO) {
        
        
        [getIngredientsScanner scanUpToString:@"<dd>" intoString:NULL] ;
        
        [getIngredientsScanner scanUpToString:@"</dd>" intoString:&getIngredients] ;
        
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<dd>"] withString:@""];
        getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"amp;"] withString:@""];
        
        //getIngredients = [getIngredients stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" "] withString:@""];
        
        
        //NSLog(@"%@", getIngredients);
        
        
        
        [getIngredientsArray addObject:getIngredients];
        
        
    }
    
    [getIngredientsArray removeLastObject];
    
    return getIngredientsArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _clickedRestaurantName;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    NSArray *saveGetCategoryNames = [[NSArray alloc] initWithArray:[self getCategoryNames]];
    NSMutableArray *saveGetMealNames = [[NSMutableArray alloc ] init];
    Meals = [[NSMutableDictionary alloc]initWithCapacity:[[self getCategoryNames] count]];

   // NSLog(@"%@", saveGetCategoryNames);
    
    
     for (int i = 0; i <= ([[self getCategoryNames] count] - 2); i++){
     
         [saveGetMealNames addObject:[self getMealNames:i]];
         
         [Meals setObject:saveGetMealNames[i] forKey:saveGetCategoryNames[i]];

         
         
     }
    

    
    //NSLog(@"%@", saveGetMealNames);
    
    

    //NSLog(@"%@", saveGetMealNames);
    
    
                
    //NSLog(@"%@", Meals);
    
    
    
    MealSectionTitles = [[Meals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    
    
    
    
    //NSLog(@"%@", [self getCategoryNames]);
    /*
    NSLog(@"%@",[self getMealNames:0]);
     NSLog(@"%@",[self getMealNames:1]);
     NSLog(@"%@",[self getMealNames:2]);
     NSLog(@"%@",[self getMealNames:3]);
     NSLog(@"%@",[self getMealNames:4]);
     NSLog(@"%@",[self getMealNames:5]);
    NSLog(@"%@",[self getMealNames:6]);
*/
    
    //Menu = @{[self getCategoryNames][0] : @[[self getMealNames:0]]};
    
    
    
    
    
    //NSLog(@"%@", [self getCategoryNames]);
    
    //NSLog(@"clicked restaurant name is %@, and its url is  %@", _clickedRestaurantName, _clickedRestaurantURL);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


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
    
    cell.detailTextLabel.text = [[self getIngredients] objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // segue to push name of clicked restaurant to the map controller
    if ([[segue identifier] isEqualToString:@"showMap"])
    {
        
        
        MapContainerViewController *MapDetailsViewController = [segue destinationViewController];
        
        MapDetailsViewController.clickedRestaurantNameInMap = _clickedRestaurantName;
        MapDetailsViewController.clickedRestaurantAddressInMap = _clickedRestaurantAddress;
        /*
        NSLog(@"%@", MapDetailsViewController.clickedRestaurantNameInMap);
        NSLog(@"%@", MapDetailsViewController.clickedRestaurantAddressInMap);
        */
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
