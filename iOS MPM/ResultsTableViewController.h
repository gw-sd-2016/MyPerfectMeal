

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController{
    
    NSMutableArray *GoodIngredients;
    NSMutableArray *BadIngredients;
    NSMutableString *LoadedHTML;
    NSMutableString *LoadedSpecificRestaurant ;
    
    
    NSMutableDictionary *tempDict;
    NSMutableArray *FinalSuggestionsArray;
    
    
    
    NSMutableArray *DisplayRestName;
    NSMutableArray *DisplayRestType;
    NSMutableArray *DisplayRestAddress;
    NSMutableArray *DisplayRestDistance;
    NSMutableArray *DisplayMealName;
    NSMutableArray *DisplayMealDesc;
    
    
}

@end
