
#import "ResultsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

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
    
    GoodIngredients = [[NSMutableArray alloc] init];
    BadIngredients = [[NSMutableArray alloc] init];
    
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
    //NSLog(@"%@", MedsCategoriesDict);
   // NSLog(@"%@", [[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"] );
    
    //NSLog(@"%@", [MedsCategoriesDict valueForKey:@"MedsCategories"] );
   
//    [self getListForGoals];

    
    //NSLog(@"%@", GoodIngredients);
    
    //NSLog(@"%@", BadIngredients);
    
    //NSLog(@"%@", [[PFUser currentUser] objectForKey:@"selectedGoal"]);
    
    
    
    
    //NSLog(@"%@", [[MedsDict objectForKey:@"Meds"][0] objectForKey:@"Name"] );
   // NSLog(@"%lu", [[MedsDict objectForKey:@"Meds"] count]);
    
    
    
    
    /*
     
     
    NSLog(@"%@", [[PFUser currentUser] objectForKey:@"selectedFoodAllergy"]);
    NSLog(@"%@", [[PFUser currentUser] objectForKey:@"selectedDisorder"]);
*/
    
    //NSLog(@"%@", [self getMedTypes]);
    
    //[self getListForMedTypes];

    [self getListForDisorders];
    
   NSLog(@"%@", GoodIngredients);
    
    NSLog(@"%@", BadIngredients);
    
    //[self getListForAllergies];
    
//    NSLog(@"%@", BadIngredients);
    

    
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
            NSLog(@"Found Heart Disease Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Heart Disease"]valueForKey:@"Bad Ingredients"]];
            
            
            
        }
        else if ([getMedTypesArray[i] isEqualToString:@"High Cholesterol Drug"]){
            NSLog(@"Found High Cholesterol Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"High Cholesterol"]valueForKey:@"Bad Ingredients"]];
            
            
            
        }
        
        else if ([getMedTypesArray[i] isEqualToString:@"Obesity Drug"]){
            NSLog(@"Found Obesity Drug" );
            
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
            NSLog(@"Found Diabetes Drug" );
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Diabetes"]valueForKey:@"Bad Ingredients"]];
            
            
        }
        
        else if ([getMedTypesArray[i] isEqualToString:@"Anxiety or Depression Drug"]){
            NSLog(@"Found Anxiety or Depression Drug" );
            
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Depression"]valueForKey:@"Bad Ingredients"]];
            
            [GoodIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Good Ingredients"]];
            [BadIngredients addObjectsFromArray:[[[MedsCategoriesDict valueForKey:@"MedsCategories"] valueForKey:@"Anxiety"]valueForKey:@"Bad Ingredients"]];
            
            
        }
        else if ([getMedTypesArray[i] isEqualToString:@"Pain Drug"]){
            NSLog(@"Found Pain Drug" );
            
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
