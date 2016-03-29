

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@import MapKit;

@interface MapContainerViewController : UIViewController <MKMapViewDelegate>

//add map and labels to the containers

@property (strong, nonatomic) IBOutlet MKMapView *restaurantMap;

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;



@property (nonatomic, strong) NSString *clickedRestaurantNameInMap;
@property (nonatomic, strong) NSString *clickedRestaurantAddressInMap;





@end
