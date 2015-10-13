//
//  CustomPlaceMark.m
//  Page
//
//  Created by Administrator on 06/10/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "CustomPlaceMark.h"

@implementation CustomPlaceMark
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) coord{
    coordinate=coord;
    return self;
}
@end
