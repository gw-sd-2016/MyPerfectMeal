

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController{
    
    NSMutableArray *GoodIngredients;
    NSMutableArray *BadIngredients;
    NSMutableString *LoadedHTML;
    NSMutableString *LoadedSpecificRestaurant ;
    
    
    NSMutableDictionary *tempDict;
    NSMutableArray *FinalSuggestionsArray;
}

@end
