
#import "RestaurantsTableViewController.h"
#import "CustomTableViewCell.h"
#import "MenuTableViewController.h"
#import "MapContainerViewController.h"

@interface RestaurantsTableViewController ()

@end

@implementation RestaurantsTableViewController



-(NSString *) loadRawHTML{
    
    NSString *link = [NSString stringWithFormat:@"http://allmenus.com/custom-results/lat/38.909942/long/-77.018128"];
    
    //NSString *link = [NSString stringWithFormat:@"http://allmenus.com/custom-results/lat/%@/long/%@/", [[[PFUser currentUser] objectForKey:@"LatStringArray"] lastObject] , [[[PFUser currentUser] objectForKey:@"LonStringArray"] lastObject]];
    NSLog(@"%@", link);
    
    NSURL *loadURL = [[NSURL alloc] initWithString:link];
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
    
    NSLog(@"Loading html called");
    
    return loadPageHTML;
    
}


-(NSInteger *) NumOfRestNearMe{
    
    NSScanner *numOfRestNearMeScanner;
    NSString *getNumOfRestNearMe = nil;
    
    numOfRestNearMeScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([numOfRestNearMeScanner isAtEnd] == NO) {
        
        
        [numOfRestNearMeScanner scanUpToString:@"<h1>We found <span id='rest_count'>" intoString:NULL] ;
        
        [numOfRestNearMeScanner scanUpToString:@"</span>" intoString:&getNumOfRestNearMe] ;
        
        getNumOfRestNearMe = [getNumOfRestNearMe stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<h1>We found <span id='rest_count'>"] withString:@""];
        
        
        
    }
    
    return [getNumOfRestNearMe integerValue];
}


-(NSMutableArray *) RestURL{
    
    NSScanner *getRestURLScanner;
    NSString *getRestURL = nil;
    NSMutableArray *getRestURLArray = [[NSMutableArray alloc] init];
    getRestURLScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([getRestURLScanner isAtEnd] == NO) {
        
        
        [getRestURLScanner scanUpToString:@"<p class=\"restaurant_name\"><a href=\"" intoString:NULL] ;
        
        [getRestURLScanner scanUpToString:@"menu/\">" intoString:&getRestURL] ;
        
        getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_name\"><a href=\""] withString:@""];
        
        getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&amp;"] withString:@"And"];
        
        [getRestURLArray addObject:getRestURL];
        
        
        
    }
    
    [getRestURLArray removeLastObject];
    
    
    
    return getRestURLArray;
}


- (NSMutableArray *) RestNames{
    
    NSScanner *getRestNamesScanner;
    NSString *getRestNames = nil;
    NSMutableArray *getRestNamesArray = [[NSMutableArray alloc] init];
    getRestNamesScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([getRestNamesScanner isAtEnd] == NO) {
        
        
        [getRestNamesScanner scanUpToString:@"/menu/\">" intoString:NULL] ;
        
        [getRestNamesScanner scanUpToString:@"</a></p>" intoString:&getRestNames] ;
        
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/menu/\">"] withString:@""];
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&amp;"] withString:@"And"];
        
        
        [getRestNamesArray addObject:getRestNames];
    }
    
    [getRestNamesArray removeLastObject];
    
    return getRestNamesArray;
    
    
    
    
}

- (NSMutableArray *) RestDistances{
    
    NSScanner *getRestDistanceScanner;
    NSString *getRestDistance = nil;
    NSMutableArray *getRestDistanceArray = [[NSMutableArray alloc] init];
    getRestDistanceScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([getRestDistanceScanner isAtEnd] == NO) {
        
        
        [getRestDistanceScanner scanUpToString:@"<p class=\"restaurant_distance\">" intoString:NULL] ;
        
        [getRestDistanceScanner scanUpToString:@" miles</p>" intoString:&getRestDistance] ;
        
        getRestDistance = [getRestDistance stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_distance\">"] withString:@""];
        
        [getRestDistanceArray addObject:getRestDistance];
        
        
    }
    
    [getRestDistanceArray removeLastObject];
    
    
    return  getRestDistanceArray;
    
}


- (NSMutableArray *) RestDesc{
    
    NSScanner *getRestDescScanner;
    NSString *getRestDesc = nil;
    NSMutableArray *getRestDescArray = [[NSMutableArray alloc] init];
    getRestDescScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([getRestDescScanner isAtEnd] == NO) {
        
        
        [getRestDescScanner scanUpToString:@"<ul class=\"restaurant_cuisines\">" intoString:NULL] ;
        
        [getRestDescScanner scanUpToString:@"</li>        </ul>" intoString:&getRestDesc] ;
        
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<ul class=\"restaurant_cuisines\">"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<li>"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"</li>"] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"        "] withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        getRestDesc = [getRestDesc stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&amp;"] withString:@"And"];
        
        [getRestDescArray addObject:getRestDesc];
        
        
    }
    
    [getRestDescArray removeLastObject];
    
    return getRestDescArray;
    
}


- (NSMutableArray *) RestAddress{
    
    NSScanner *getRestAddressScanner;
    NSString *getRestAddress = nil;
    NSMutableArray *getRestAddressArray = [[NSMutableArray alloc] init];
    getRestAddressScanner = [NSScanner scannerWithString:loadedHTMLPage];
    
    while ([getRestAddressScanner isAtEnd] == NO) {
        
        
        [getRestAddressScanner scanUpToString:@"<p class=\"restaurant_address\">" intoString:NULL] ;
        
        [getRestAddressScanner scanUpToString:@"</p>" intoString:&getRestAddress] ;
        
        getRestAddress = [getRestAddress stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_address\">"] withString:@""];

        
        [getRestAddressArray addObject:getRestAddress];
        
        
    }
    
    [getRestAddressArray removeLastObject];
    
    
    return getRestAddressArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loadedHTMLPage = [self loadRawHTML];
    //register new custom table view cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCell class])];
    
    _clickedRestaurant = [[NSString alloc] init];
    _clickedURL = [[NSString alloc] init];
    
    
    allRestNames = [self RestNames];
    allRestTypes = [self RestDesc];
    allRestAddresses = [self RestAddress];
    allRestDistances = [self RestDistances];
    allRestURLs = [self RestURL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCell class]) forIndexPath:indexPath];
    
    cell.restNameLBL.text = [allRestNames objectAtIndex:indexPath.row];
    cell.restTypeLBL.text = [allRestTypes objectAtIndex:indexPath.row];
    cell.restAddressLBL.text = [allRestAddresses objectAtIndex:indexPath.row];
    cell.restDistanceLBL.text = [allRestDistances objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //get clicked restaurant name
    _clickedRestaurant = [allRestNames objectAtIndex:indexPath.row];
    _clickedURL = [allRestURLs objectAtIndex:indexPath.row];
    _clickedAddress = [allRestAddresses objectAtIndex:indexPath.row];
    
    
    
    [self performSegueWithIdentifier:@"showMenu" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMenu"])
    {
        
        
        MenuTableViewController *MenuDetailsViewController = [segue destinationViewController];
        
        MenuDetailsViewController.clickedRestaurantName = _clickedRestaurant;
        MenuDetailsViewController.clickedRestaurantURL = _clickedURL;
        MenuDetailsViewController.clickedRestaurantAddress = _clickedAddress;
        

    }
    
}


- (IBAction)refreshRestBTN:(id)sender {
    loadedHTMLPage = [self loadRawHTML];
    //register new custom table view cell
    
    allRestNames = [self RestNames];
    allRestTypes = [self RestDesc];
    allRestAddresses = [self RestAddress];
    allRestDistances = [self RestDistances];
    allRestURLs = [self RestURL];
    
    
    [self.tableView reloadData];
    
    
}
@end