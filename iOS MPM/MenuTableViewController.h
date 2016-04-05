

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController{
    
    NSMutableDictionary *Meals;
    NSArray *MealSectionTitles;
    NSString *clickedMealString;
    NSString *clickedMealIngredientsString;
}


@property (nonatomic, strong) NSString *clickedRestaurantName;
@property (nonatomic, strong) NSString *clickedRestaurantURL;
@property (nonatomic, strong) NSString *clickedRestaurantAddress;




@end
