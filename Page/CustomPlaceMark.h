//
//  CustomPlaceMark.h
//  Page
//
//  Created by Administrator on 06/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomPlaceMark : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
  }
@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSString *subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coordinate;
- (NSString *)subtitle;
- (NSString *)title;
@end
