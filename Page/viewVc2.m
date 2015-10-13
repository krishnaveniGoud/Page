//
//  viewVc2.m
//  Page
//
//  Created by Administrator on 05/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "viewVc2.h"

@implementation viewVc2
@synthesize locationManager;
@synthesize coordinate;
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"2");
    self.search.delegate = self;
    if(![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"You need to enable location services to use this app");
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Enable Location Services" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=Location Services"]];
    }
    
    if(locationManager==nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.pausesLocationUpdatesAutomatically=NO;
        
        
        NSString *version = [[UIDevice currentDevice] systemVersion];
        NSLog(@"system version %@",version);
        if([version floatValue] > 7.0f)
        {
            if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [locationManager requestWhenInUseAuthorization];
                [locationManager requestAlwaysAuthorization];
                [locationManager requestAlwaysAuthorization];
            }
        }
    }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter=50.0f;
    [locationManager startUpdatingLocation];
    
}
/*- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    NSLog(@"Detected Location : %f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           return;
                       }
                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       NSString *countryName = placemark.country;
                      
                        NSLog(@"placemark.ISOcountryCode %@",placemark.addressDictionary);
                     
                       NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                       NSString *latDest1 = [NSString stringWithFormat:@"%.4f",placemark.location.coordinate.latitude];
                       NSLog(@"%@",latDest1);
                       NSString *lngDest1 = [NSString stringWithFormat:@"%.4f",placemark.location.coordinate.longitude];
                       
                       NSLog(@"%@",lngDest1);
                       CGFloat num1 = [latDest1 doubleValue];
                       CGFloat num2 = [lngDest1 doubleValue];
                       CLLocationCoordinate2D zoomLocation;
                       zoomLocation.latitude = num1;
                       zoomLocation.longitude= num2;
                       // MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1609.344,1609.344);
                       
                       MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                       point.coordinate = zoomLocation;
                       point.title  = placemark.name;
                       
                       //  [_mapView setRegion:viewRegion animated:YES];
                       [_mapView addAnnotation:point];
                       
                       
                   }];
}*/

-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"2");
    
}
- (IBAction)checkAction:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    if (seg.selectedSegmentIndex == 0) {
        self.mapView.mapType = MKMapTypeStandard;
    }
    else if (seg.selectedSegmentIndex == 1) {
        self.mapView.mapType = MKMapTypeSatellite;
    }
    else if (seg.selectedSegmentIndex == 2) {
       self.mapView.mapType = MKMapTypeStandard;
    }
    
    
}
#pragma mark annotation callbacks
/*- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    NSLog(@"This is called");
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"customloc"];
    [annView setPinColor:MKPinAnnotationColorPurple];
    return annView;
}

#pragma mark location callbacks
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"location found... updating region");
    [self addPins:newLocation.coordinate.latitude lon:newLocation.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"location not available");
}


#pragma mark geo functions
-(void)addPins:(float)lat lon:(float)lon{
    
    CLLocationCoordinate2D location;
    location.latitude = lat;
    location.longitude = lon;
    
    // forcus around you
    MKCoordinateRegion region;
    region.center=location;
    MKCoordinateSpan span;
    span.latitudeDelta=0.005f; // this should be adjusted for high vs. low latitude - calc by cosign or sign
    span.longitudeDelta=0.005f;
    region.span=span;
    [self.mapView setRegion:region animated:TRUE];
    
    // boundly
    float westLon = region.center.longitude - region.span.longitudeDelta;
    //float eastLon = region.center.longitude + region.span.longitudeDelta;
    //float northLat = region.center.latitude + region.span.latitudeDelta;
    float southLat = region.center.latitude - region.span.latitudeDelta;
    
    ///////////////////////////////////////////////////////////////////////////////////////////
    // got current location here...
    // then put some pins
    for (int i=0; i<100; i++) {
        CLLocationCoordinate2D location;
        
        // random fill the screen -> this should convert to database driven coordinates
        location.latitude=southLat + (region.span.latitudeDelta/50.0f)*(arc4random()%100);
        location.longitude=westLon + (region.span.longitudeDelta/50.0f)*(arc4random()%100);
        
        // add custom place mark
        CustomPlaceMark *placemark=[[CustomPlaceMark alloc] initWithCoordinate:location];
        placemark.title = @"Title Here";
        placemark.subtitle = @"Subtitle Here";
        [self.mapView addAnnotation:placemark];
       
    }
}


-(CLLocationCoordinate2D) getLocationFromAddress:(NSString*) address {
    // in case of error use api key like
    // http://maps.google.com/maps/geo?q=%@&output=csv&key=YourGoogleMapsAPIKey
    //http://maps.google.com/maps/geo?q=%@&output=csv
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv&key=AIzaSyAn4qB7cZY77gAiOu9WVur4kYfdh370XRA",
                           [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
    
    double latitude = 0.0;
    double longitude = 0.0;
    
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        latitude = [[listItems objectAtIndex:2] doubleValue];
        longitude = [[listItems objectAtIndex:3] doubleValue];
    }
    else {
        //Show error
        NSLog(@"error:address not found");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Address not found"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
       
    }
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    
    return location;
}

#pragma mark search delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    CLLocationCoordinate2D location2d = [self getLocationFromAddress:searchBar.text];	
    [self addPins:location2d.latitude lon:location2d.longitude];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [ self.search resignFirstResponder];
}*/
@end
