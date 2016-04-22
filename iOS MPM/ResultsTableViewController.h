

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController{
    
    NSMutableArray *GoodIngredients;
    NSMutableArray *BadIngredients;
    NSMutableString *LoadedHTML;
    NSMutableString *LoadedSpecificRestaurant ;
    
    
    NSMutableArray *restDictArray;
    
}

@end
