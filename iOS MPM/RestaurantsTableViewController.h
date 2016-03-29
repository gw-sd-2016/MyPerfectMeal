

#import <UIKit/UIKit.h>

@interface RestaurantsTableViewController : UITableViewController{
    

    NSMutableArray *allRestNames;
    NSMutableArray *allRestTypes;
    NSMutableArray *allRestAddresses;
    NSMutableArray *allRestDistances;
    NSMutableArray *allRestURLs;

    
}


@property (nonatomic, strong) NSString *clickedRestaurant;
@property (nonatomic, strong) NSString *clickedURL;
@property (nonatomic, strong) NSString *clickedAddress;








@end
