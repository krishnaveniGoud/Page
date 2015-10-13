//
//  viewVc3.m
//  Page
//
//  Created by Administrator on 05/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "viewVc3.h"

@implementation viewVc3
@synthesize mapView;
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"3");
    self.search.delegate = self;
    mapView.delegate = self;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"3");
   
    
    
}
/*- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.search resignFirstResponder];
}*/
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    // called only once
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // called twice every time
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    // called only once
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    /*GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;*/
    
   /* CLLocationCoordinate2D location = [self getLocationFromAddress:@"700 Northern Blvd, Greenvale 11358"];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = location;
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;*/
    // called only once
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    CLLocationCoordinate2D location = [self getLocationFromAddress:searchBar.text];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = location;
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
   
}
-(CLLocationCoordinate2D) getLocationFromAddress:(NSString*) address {
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?",
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
    }
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    
    return location;
}
@end
