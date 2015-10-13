//
//  viewVc3.h
//  Page
//
//  Created by Administrator on 05/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@interface viewVc3 : UIViewController<UISearchBarDelegate,GMSMapViewDelegate>
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) IBOutlet  GMSMarker *placeMarker;

@end
