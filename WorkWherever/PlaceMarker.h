//
//  PlaceMarker.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/20/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "Place.h"

@interface PlaceMarker : GMSMarker

@property (strong, nonatomic) Place *place;

@end
