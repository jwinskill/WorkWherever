//
//  MapViewController.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/17/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"
#import "InfoWindow.h"
#import "PlaceMarker.h"
#import "NetworkController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MapViewController : UIViewController <CLLocationManagerDelegate, UISearchBarDelegate, GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) CLLocation *myLocation;

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker;

@end
