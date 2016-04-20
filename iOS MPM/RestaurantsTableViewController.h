

#import <UIKit/UIKit.h>

@interface RestaurantsTableViewController : UITableViewController{
    

    NSMutableArray *allRestNames;
    NSMutableArray *allRestTypes;
    NSMutableArray *allRestAddresses;
    NSMutableArray *allRestDistances;
    NSMutableArray *allRestURLs;
    NSString *loadedHTMLPage;

    
}

@property (nonatomic, strong) NSString *clickedRestaurant;
@property (nonatomic, strong) NSString *clickedURL;
@property (nonatomic, strong) NSString *clickedAddress;

- (IBAction)refreshRestBTN:(id)sender;





@end
