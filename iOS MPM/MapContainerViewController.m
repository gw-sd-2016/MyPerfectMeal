

#import "MapContainerViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MapContainerViewController ()

@end

@implementation MapContainerViewController

@synthesize restaurantMap;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    self.nameLbl.text = _clickedRestaurantNameInMap;
    self.addressLbl.text = _clickedRestaurantAddressInMap;
    

                //use the apple's geocoder to translate an address to logng and lat
                NSString *fullAddress =  _clickedRestaurantAddressInMap;
                NSString *location = fullAddress;
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                [geocoder geocodeAddressString:location
                             completionHandler:^(NSArray* placemarks, NSError* error){
                                 if (placemarks && placemarks.count > 0) {
                                     //placemark for the first result
                                     CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                     MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                     
                                     //formating info
                                     MKCoordinateRegion region = self.restaurantMap.region;
                                     region.center = placemark.location.coordinate;
                                     region.span.longitudeDelta /= 5000;
                                     region.span.latitudeDelta /= 5000;
                                     
                                     //animation and display the address on the map
                                     [self.restaurantMap setRegion:region animated:false];
                                     [self.restaurantMap addAnnotation:placemark];
                                     [self.view addSubview:restaurantMap];
                                     
                                 }
                             }
                 ];
 

     
}



@end
