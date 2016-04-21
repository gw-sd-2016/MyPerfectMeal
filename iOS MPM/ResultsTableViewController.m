
#import "ResultsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

-(NSString *) getCloseRestHTML{ //This is the page for the full list of rest names/address
    
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
    
    //NSLog(@"Loaded HTML Page");
    
    return loadPageHTML;
    
}

-(NSMutableArray *) RestURL{ //get urls for all restaurants
    
    NSScanner *getRestURLScanner;
    NSString *getRestURL = nil;
    NSMutableArray *getRestURLArray = [[NSMutableArray alloc] init];
    getRestURLScanner = [NSScanner scannerWithString:LoadedHTML];
    
    while ([getRestURLScanner isAtEnd] == NO) {
        
        
        [getRestURLScanner scanUpToString:@"<p class=\"restaurant_name\"><a href=\"" intoString:NULL] ;
        
        [getRestURLScanner scanUpToString:@"menu/\">" intoString:&getRestURL] ;
        
        getRestURL = [getRestURL stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_name\"><a href=\""] withString:@""];
        
        [getRestURLArray addObject:getRestURL];
        
        
        
    }
    
    [getRestURLArray removeLastObject];
    
   // NSLog(@"%@", getRestURLArray);
    
    
    return getRestURLArray;
}

- (NSMutableArray *) RestDistances{ //get distances of all restaurants
    
    NSScanner *getRestDistanceScanner;
    NSString *getRestDistance = nil;
    NSMutableArray *getRestDistanceArray = [[NSMutableArray alloc] init];
    getRestDistanceScanner = [NSScanner scannerWithString:LoadedHTML];
    
    while ([getRestDistanceScanner isAtEnd] == NO) {
        
        
        [getRestDistanceScanner scanUpToString:@"<p class=\"restaurant_distance\">" intoString:NULL] ;
        
        [getRestDistanceScanner scanUpToString:@" miles</p>" intoString:&getRestDistance] ;
        
        getRestDistance = [getRestDistance stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_distance\">"] withString:@""];
        
        
        //get all rest names
        //NSLog(@"%f", [getRestDistance doubleValue]);
        
        [getRestDistanceArray addObject:getRestDistance];
        
        
    }
    
    [getRestDistanceArray removeLastObject];
    
    //NSLog(@"%@", getRestDistanceArray);
    
    return  getRestDistanceArray;
    
}

- (NSMutableArray *) RestAddress{
    
    NSScanner *getRestAddressScanner;
    NSString *getRestAddress = nil;
    NSMutableArray *getRestAddressArray = [[NSMutableArray alloc] init];
    getRestAddressScanner = [NSScanner scannerWithString:LoadedHTML];
    
    while ([getRestAddressScanner isAtEnd] == NO) {
        
        
        [getRestAddressScanner scanUpToString:@"<p class=\"restaurant_address\">" intoString:NULL] ;
        
        [getRestAddressScanner scanUpToString:@"</p>" intoString:&getRestAddress] ;
        
        getRestAddress = [getRestAddress stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<p class=\"restaurant_address\">"] withString:@""];
        
        //get all rest names
        //NSLog(@"%@", getRestAddress);
        
        
        [getRestAddressArray addObject:getRestAddress];
        
        
    }
    
    [getRestAddressArray removeLastObject];
    
    //NSLog(@"%@", getRestAddressArray);
    
    return getRestAddressArray;
    
}

- (NSMutableArray *) RestNames{
    
    NSScanner *getRestNamesScanner;
    NSString *getRestNames = nil;
    NSMutableArray *getRestNamesArray = [[NSMutableArray alloc] init];
    getRestNamesScanner = [NSScanner scannerWithString:LoadedHTML];
    
    while ([getRestNamesScanner isAtEnd] == NO) {
        
        
        [getRestNamesScanner scanUpToString:@"/menu/\">" intoString:NULL] ;
        
        [getRestNamesScanner scanUpToString:@"</a></p>" intoString:&getRestNames] ;
        
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/menu/\">"] withString:@""];
        getRestNames = [getRestNames stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"&amp;"] withString:@"And"];
        
        [getRestNamesArray addObject:getRestNames];
    }
    
    [getRestNamesArray removeLastObject];
    
   // NSLog(@"%@", getRestNamesArray);
    
    return getRestNamesArray;
}

- (NSMutableArray *) RestDesc{
    
    NSScanner *getRestDescScanner;
    NSString *getRestDesc = nil;
    NSMutableArray *getRestDescArray = [[NSMutableArray alloc] init];
    getRestDescScanner = [NSScanner scannerWithString:LoadedHTML];
    
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
        
        
        //get all rest names
        //NSLog(@"%@", getRestDesc);
        
    }
    
    [getRestDescArray removeLastObject];
    
    //NSLog(@"%@", getRestDescArray);
    
    return getRestDescArray;
    
}



-(NSString *) loadRawHTML: (int) X{ //now load the url for a specific website
    
    NSMutableString *restaurantDirectoryURLString= [NSMutableString stringWithFormat:@"http://www.allmenus.com%@", [self RestURL][X]];
    
    //NSLog(@"Navigating to %@", restaurantDirectoryURLString);
    
    
    NSURL *restaurantDirectoryURL = [[NSURL alloc] initWithString:restaurantDirectoryURLString];
    NSString *loadPageHTML = [[NSString alloc] initWithContentsOfURL:restaurantDirectoryURL];
    
    NSScanner *getHTMLScanner;
    NSString *loadHTMLPage = @"";
    getHTMLScanner = [NSScanner scannerWithString:loadPageHTML];
    
    while ([getHTMLScanner isAtEnd] == NO) {
        
        [getHTMLScanner scanUpToString:@"<div id=\"menu\"" intoString:NULL] ;
        [getHTMLScanner scanUpToString:@"<!-- foreach menu -->" intoString:&loadHTMLPage] ;
        
        
    }
    
    //NSLog(@"Loaded Raw Html For A Specific Restaurant");
    
    //NSLog(@"%@", loadHTMLPage);
    
    
    return loadHTMLPage;
    
}


-(NSMutableArray *) getMealNames: (int) Y{
    
    NSScanner *getMealNamesScanner;
    NSString *getMeals = nil;
    getMealNamesScanner = [NSScanner scannerWithString:LoadedSpecificRestaurant];
    NSMutableArray  *getMealNamesArray = [[NSMutableArray alloc] init];
    
    while ([getMealNamesScanner isAtEnd] == NO) {
        
        
        [getMealNamesScanner scanUpToString:@"<span class=\"name\">" intoString:NULL] ;
        [getMealNamesScanner scanUpToString:@"</span>" intoString:&getMeals] ;
        
        getMeals = [getMeals stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"<span class=\"name\">"] withString:@""];
        
        
        [getMealNamesArray addObject:getMeals];
        
        
        
    }
    
    [getMealNamesArray removeLastObject];
    
    //NSLog(@"%@", getMealNamesArray);
    
    return getMealNamesArray;
    
    
    
}

-(NSString *) getIngredients: (NSString *) mealName : (int) Y{
    
    
    NSMutableString *scannerBeginingString = [[NSMutableString alloc] initWithFormat:@"<span class=\"name\">%@</span>", mealName];
    
    NSScanner *getIngredientsScanner;
    NSString *getIngredients = nil;
    getIngredientsScanner = [NSScanner scannerWithString:LoadedSpecificRestaurant];
    
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
    
    LoadedHTML = [self getCloseRestHTML];
    
    NSMutableArray *restDictArray = [[NSMutableArray alloc] init];
    
    
    for (int ak = 0; ak <= 6;ak++) {
        
    LoadedSpecificRestaurant = [self loadRawHTML:ak];
    /*
    NSLog(@"%@", [self RestNames][ak]);
    NSLog(@"%@", [self RestDesc][ak]);
    NSLog(@"%@", [self RestAddress][ak]);
    NSLog(@"%@", [self RestDistances][ak]);
*/
        
        
    NSArray *FinalMeals = [[NSArray alloc] initWithArray:[self getMealNames:ak]];
        
    FinalMeals = [FinalMeals sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
        if ([FinalMeals count] != 0){
            
        NSMutableArray *temp = [[NSMutableArray alloc] init];

        for (int i =0; i <= [FinalMeals count]-1; i++) {
                
        [temp addObject:[self getIngredients:FinalMeals[i] :ak]];
                
        }
            
        NSDictionary *MealsDict = [NSDictionary dictionaryWithObjects:temp forKeys:FinalMeals];

        [restDictArray addObject:MealsDict];
            
        }
        
        else{
            
        }
    
    }
    
    
    
    GoodIngredients = [[NSMutableArray alloc] init];
    BadIngredients = [[NSMutableArray alloc] init];
    
    
    
    [self getListForUserLikesAndDislikes];
    [self getListForDisorders];
    [self getListForAllergies];
    [self getListForMedTypes];
    [self getListForGoals];
    
    NSOrderedSet *orderedSetGoodIngredients = [NSOrderedSet orderedSetWithArray:GoodIngredients];
    GoodIngredients = [orderedSetGoodIngredients array];
    
    NSOrderedSet *orderedSetBadIngredients = [NSOrderedSet orderedSetWithArray:BadIngredients];
    BadIngredients = [orderedSetBadIngredients array];
    

    
    NSMutableArray *potentialSuggestions = [[NSMutableArray alloc] init];
    
    int AXZ = 3;
    
    for (int j = 0; j <= [[restDictArray[AXZ] allValues] count] -1 ; j++){
        
        for (int i = 0; i <= [GoodIngredients count] -1; i++){
            if ([[restDictArray[AXZ] allValues][j] containsString:GoodIngredients[i]]){
                //NSLog(@"Found a match %@ contains the word %@", [restDictArray[1] allValues][j], GoodIngredients[i]);
                //NSLog(@"%@", [restDictArray[1] allValues][j]);
                
                if ([[restDictArray[AXZ] allValues][j] length] <= 100){
                   // NSLog(@"TOO SHORT THIS WILL BE IGNORED");
                }
                else{
                    [potentialSuggestions addObject:[restDictArray[AXZ] allValues][j]];
                }
                
            }
            else{
                //NSLog(@"KEYWORD NOT FOUND");
                
            }
        }
        
    }
    

    NSMutableArray *SecondSuggestionFilter = [[NSMutableArray alloc] init];

    
    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:potentialSuggestions];
    //NSLog(@"%@", countedSet);
    
    for (id item in countedSet)
    {
        
        if ((unsigned long)[countedSet countForObject:item] <= 3){
            //NSLog(@"NOT ENOUGH LIKES");
        }
        else{
            //NSLog(@"Name=%@, Count=%lu", item, (unsigned long)[countedSet countForObject:item]);
            [SecondSuggestionFilter addObject:item];
        }
        
        
    }
    
    //NSLog(@"%@", SecondSuggestionFilter);
    
    

    NSMutableArray *ThirdSuggestionFilter = [[NSMutableArray alloc] init];
    NSMutableArray *badStrings = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= [SecondSuggestionFilter count] -1; i++){
        for (int j = 0; j <= [BadIngredients count] -1; j++){
            if ([SecondSuggestionFilter[i] containsString:BadIngredients[j]]){
               //This is a bad string
                //NSLog(@"Added Bad String: %@.", SecondSuggestionFilter[i]);
                [badStrings addObject:SecondSuggestionFilter[i]];
                //NSLog(@"Found word %@", BadIngredients[j]);
            }
        }
        
        if ( [badStrings containsObject:SecondSuggestionFilter[i]]){
            //NSLog(@"BAD STRING: %@" , SecondSuggestionFilter[i]);
        }
        else{
            [ThirdSuggestionFilter addObject:SecondSuggestionFilter[i]];

        }
        
    }
    
    NSLog(@"%@", ThirdSuggestionFilter);
    
}

-(void) getListForUserLikesAndDislikes{
    
    
    [GoodIngredients addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedLikes"]];
    
    [BadIngredients addObjectsFromArray:[[PFUser currentUser] objectForKey:@"selectedDislikes"]];
    
    
}


-(void) getListForDisorders{
    
    NSMutableArray *getSelectedDisordersArray = [[PFUser currentUser] objectForKey:@"selectedDisorder"];

    NSString *MedsCategoriesPath = [[NSBundle mainBundle] pathForResource:@"MedsCategories" ofType:@"plist"];
    NSDictionary *MedsCategoriesDict = [[NSDictionary alloc] initWithContentsOfFile:MedsCategoriesPath];
   
    
    for (int i = 0; i <= [getSelectedDisordersArray count] -1; i++ ){
        
        if ([getSelectedDisordersArray[i] isEqualToString:@"Heart Disease"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Bad Ingredients"]];

        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"High Blood Pressure"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"High Cholesterol"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Asthma"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Asthma"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Asthma"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Diabetes"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Frequent Headaches"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Depression"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Anxiety"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Gastrointestinal Problems"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        else if ([getSelectedDisordersArray[i] isEqualToString:@"Alzheimer's Disease"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Alzheimer's Disease"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Alzheimer's Disease"]valueForKey:@"Bad Ingredients"]];
            
        }
        
        
    }
}








-(void) getListForAllergies{
    
    NSString *AllergiesPath = [[NSBundle mainBundle] pathForResource:@"Allergies" ofType:@"plist"];
    NSDictionary *AllergiesDict = [[NSDictionary alloc] initWithContentsOfFile:AllergiesPath];
    
    NSMutableArray *getSelectedFoodAllergyArray = [[PFUser currentUser] objectForKey:@"selectedFoodAllergy"];
    
    //NSLog(@"%@", [[AllergiesDict objectForKey:@"Allergies"] allKeys] );
    
    for (int i = 0; i <= [getSelectedFoodAllergyArray count] -1; i++ ){
        
        if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Shellfish"]){

            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Shellfish"]];
            
            
        }
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Nuts"]){
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Nuts"]];
            
        }
        
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Egg"]){
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Egg"]];
            
        }
        
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Soy"]){
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Soy"]];
            


        }
        
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Wheat"]){
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Wheat"]];
            

        }
        
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Fish"]){
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Fish"]];
            
        }
        
        else if ([getSelectedFoodAllergyArray[i] isEqualToString:@"Milk Products"]){
            
            
            [BadIngredients addObjectsFromArray:[[AllergiesDict objectForKey:@"Allergies"] valueForKey:@"Milk Products"]];
            
        }
    }
    
}



-(void) getListForMedTypes{
    
    NSMutableArray *getMedTypesArray = [[NSMutableArray alloc] init];
    getMedTypesArray = [self getMedTypes];
    
    NSString *MedsCategoriesPath = [[NSBundle mainBundle] pathForResource:@"MedsCategories" ofType:@"plist"];
    NSDictionary *MedsCategoriesDict = [[NSDictionary alloc] initWithContentsOfFile:MedsCategoriesPath];
    
    
    for (int i = 0; i <= [getMedTypesArray count]-1; i++){
        
        if ([getMedTypesArray[i] isEqualToString:@"Heart Disease Drug"]){
            //NSLog(@"Found Heart Disease Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Bad Ingredients"]];
            
            
            
        }
        else if ([getMedTypesArray[i] isEqualToString:@"High Cholesterol Drug"]){
           // NSLog(@"Found High Cholesterol Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Bad Ingredients"]];
            
            
            
        }
        
        else if ([getMedTypesArray[i] isEqualToString:@"Obesity Drug"]){
            //NSLog(@"Found Obesity Drug" );
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];

            
            
        }
        
        else if ([getMedTypesArray[i] isEqualToString:@"Diabetes Drug"]){
            //NSLog(@"Found Diabetes Drug" );
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Bad Ingredients"]];
            
            
        }
        
        else if ([getMedTypesArray[i] isEqualToString:@"Anxiety or Depression Drug"]){
          //  NSLog(@"Found Anxiety or Depression Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Bad Ingredients"]];
            
            
        }
        else if ([getMedTypesArray[i] isEqualToString:@"Pain Drug"]){
            //NSLog(@"Found Pain Drug" );
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Bad Ingredients"]];
            
            
        }
        else if ([getMedTypesArray[i] isEqualToString:@"Infection Drug"]){
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Frequent Headaches"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Bad Ingredients"]];
        }
        else{
            NSLog(@"User Not Taking Any Drugs");
        }

        
        
    }
    
    
    
    
}




- (NSMutableArray*) getMedTypes{

    //NSLog(@"%@", [[PFUser currentUser] objectForKey:@"selectedMeds"]);
    NSMutableArray *foundTypes = [[NSMutableArray alloc] init];
    NSString *MedsPath = [[NSBundle mainBundle] pathForResource:@"Meds" ofType:@"plist"];
    NSDictionary *MedsDict = [[NSDictionary alloc] initWithContentsOfFile:MedsPath];
    
    //NSLog(@"%@", MedsDict);

    
    for (int i = 0; i <= [[MedsDict objectForKey:@"Meds"] count] -1 ; i++){
        
        for (int j = 0; j <= [[[PFUser currentUser] objectForKey:@"selectedMeds"] count] -1; j++){
            if ([[[MedsDict objectForKey:@"Meds"][i] objectForKey:@"Name"] isEqualToString:[[PFUser currentUser] objectForKey:@"selectedMeds"][j]]){
                
               // NSLog(@"%@ is an %@", [[PFUser currentUser] objectForKey:@"selectedMeds"][j] , [[MedsDict objectForKey:@"Meds"][i] objectForKey:@"Type"]);
                [foundTypes addObject:[[MedsDict objectForKey:@"Meds"][i] objectForKey:@"Type"]];
            }
        }
       
    }
    
    return foundTypes;
}


-(void) getListForGoals{
    
    NSString *MedsCategoriesPath = [[NSBundle mainBundle] pathForResource:@"MedsCategories" ofType:@"plist"];
    NSDictionary *MedsCategoriesDict = [[NSDictionary alloc] initWithContentsOfFile:MedsCategoriesPath];
    
    if ( [[[PFUser currentUser] objectForKey:@"selectedGoal"] isEqualToString:@"No Weight Goals" ] || [[[PFUser currentUser] objectForKey:@"selectedGoal"] isEqualToString:@"Gain Weight" ] ){
        NSLog(@"User can eat anything!");
    }
    else if ([[[PFUser currentUser] objectForKey:@"selectedGoal"] isEqualToString:@"Maintain Current Weight" ] || [[[PFUser currentUser] objectForKey:@"selectedGoal"] isEqualToString:@"Lose Weight" ]){
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Bad Ingredients"]];
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Blood Pressure"]valueForKey:@"Bad Ingredients"]];
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Bad Ingredients"]];
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Gastrointestinal Problems"]valueForKey:@"Bad Ingredients"]];
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Bad Ingredients"]];
        
        [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
        [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
    }

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



@end
