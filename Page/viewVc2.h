//
//  viewVc2.h
//  Page
//
//  Created by Administrator on 05/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKPinAnnotationView.h>
#import <MapKit/MKReverseGeocoder.h>
#import "CustomPlaceMark.h"

@interface viewVc2 : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation,UISearchBarDelegate>{
    MKPlacemark *mPlacemark;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

    
}
@property (strong, nonatomic) IBOutlet UISearchBar *search;


- (IBAction)checkAction:(id)sender;
-(void)addPins:(float)lat lon:(float)lon;
-(CLLocationCoordinate2D) getLocationFromAddress:(NSString*) address;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKAnnotationView * annotation;
@end
