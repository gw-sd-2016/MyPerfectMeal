//
//  MapContainerViewController.h
//  iOS MPM
//
//  Created by Abed Kassem on 11/17/15.
//  Copyright © 2015 Abed Kassem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@import MapKit;

@interface MapContainerViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *restaurantMap;

@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressOneLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressTwoLbl;


@property (nonatomic, strong) NSString *clickedRestaurant2;



@end
