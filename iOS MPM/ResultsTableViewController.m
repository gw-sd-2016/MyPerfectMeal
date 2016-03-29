
#import "ResultsTableViewController.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

-(NSString *) getCloseRestHTML{
    
    //load url of near me restaurants
    NSURL *loadURL = [[NSURL alloc] initWithString:@"http://allmenus.com/custom-results/lat/38.8991833/long/-77.048883/"];
    NSStringEncoding encoding;
    NSError *error = nil;
    //Load HTML link
    //Store HTML Page for "X amount of restaurants Page"
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:loadURL
                                                        usedEncoding:&encoding
                                                               error:&error];
    
    
    
    
    NSScanner *allRestNearMeHTMLScanner;
    NSString *text = @"";
    allRestNearMeHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([allRestNearMeHTMLScanner isAtEnd] == NO) {
        
        [allRestNearMeHTMLScanner scanUpToString:@"<" intoString:NULL] ;
        [allRestNearMeHTMLScanner scanUpToString:@">" intoString:&text] ;
        
        
    }
    
    //NSLog(@"%@", loadPageHTML);
    
    return loadPageHTML;
    
}

-(NSMutableArray *) RestURL{
    
    NSScanner *getRestURLScanner;
    NSString *getRestURL = nil;
    NSMutableArray *getRestURLArray = [[NSMutableArray alloc] init];
    getRestURLScanner = [NSScanner scannerWithString:[self getCloseRestHTML]];
    
    while ([getRestURLScanner isAtEnd] == NO) {
        
        
        [getRestURLScanner scanUpToString:@"<p class=\"restaurant_name\"><a href=\"" intoString:NULL] ;
        
        [getRestURLScanner scanUpToString:@"menu/\">" intoString:&getRestURL] ;
        
        getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_name\"><a href=\""] withString:@""];
        
        
        
         //this gets all urls on the page
        
        /*
         if (![getRestURLArray containsObject:getRestURL]){
         [getRestURLArray addObject:getRestURL];
         
         }
         else{
         //NSLog(@" found before %@", getRestURL);
         }
        */
        [getRestURLArray addObject:getRestURL];
        
        
        
    }
    
    [getRestURLArray removeLastObject];
    
    //NSLog(@"%@", getRestURLArray);

    
    return getRestURLArray;
}

-(NSString *) getSpecificRestHTML: (int) Y{
    
    //load url of the specifc restaurant near me
    NSMutableString *getSpecificRestURLString= [NSMutableString stringWithFormat:@"http://m.allmenus.com%@", [self RestURL][Y]];

    NSURL *loadURL = [[NSURL alloc] initWithString:getSpecificRestURLString];
    NSStringEncoding encoding;
    NSError *error = nil;
    //Load HTML link

    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:loadURL
                                                        usedEncoding:&encoding
                                                               error:&error];
    
    
    
    
    NSScanner *allRestNearMeHTMLScanner;
    NSString *text = @"";
    allRestNearMeHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([allRestNearMeHTMLScanner isAtEnd] == NO) {
        
        [allRestNearMeHTMLScanner scanUpToString:@"<" intoString:NULL] ;
        [allRestNearMeHTMLScanner scanUpToString:@">" intoString:&text] ;
        
        
    }
    
    //NSLog(@"%@", loadPageHTML);
    
    return loadPageHTML;
    
}

-(NSMutableArray *) getIngredients: (int) X{
    
    NSScanner *getIngredientsScanner;
    NSString *getIngredients = nil;
    getIngredientsScanner = [NSScanner scannerWithString:[self getSpecificRestHTML:X]];
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
    /*
    //NSLog(@"The first restuarant is %@, the second restuarant is %@, the third restaurant is %@", [self RestURL][0], [self RestURL][1], [self RestURL][2]);
    NSLog(@"This is the ingredits of the first restaurant in the list %@", [self getIngredients:0]);
    NSLog(@"This is the ingredits of the second restaurant in the list %@", [self getIngredients:1]);
    NSLog(@"This is the ingredits of the third restaurant in the list %@", [self getIngredients:2]);
    
    
    NSString *MedsPath = [[NSBundle mainBundle] pathForResource:@"Meds" ofType:@"plist"];
    NSDictionary *MedsDict = [[NSDictionary alloc] initWithContentsOfFile:MedsPath];
    NSLog(@"%@", MedsDict);
   
    
    NSString *MedsCategoriesPath = [[NSBundle mainBundle] pathForResource:@"MedsCategories" ofType:@"plist"];
    NSDictionary *MedsCategoriesDict = [[NSDictionary alloc] initWithContentsOfFile:MedsCategoriesPath];
    NSLog(@"%@", MedsCategoriesDict);
    
    
    NSString *AllergiesPath = [[NSBundle mainBundle] pathForResource:@"Allergies" ofType:@"plist"];
    NSDictionary *AllergiesDict = [[NSDictionary alloc] initWithContentsOfFile:AllergiesPath];
    NSLog(@"%@", AllergiesDict);
    

    
    NSString *GoalsPath = [[NSBundle mainBundle] pathForResource:@"Goals" ofType:@"plist"];
    NSDictionary *GoalsDict = [[NSDictionary alloc] initWithContentsOfFile:GoalsPath];
    NSLog(@"%@", GoalsDict);
     */
    
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

    //cell.textLabel.text = [[self RestURL] objectAtIndex:indexPath.row];
    
    return cell;
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
