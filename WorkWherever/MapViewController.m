//
//  MapViewController.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/17/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@implementation MapViewController {
    GMSMapView *mapView_;
    CLLocationManager *locationManager;
    BOOL updatedLocation_;
}

- (void)viewDidLoad {
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
  //  UIImage *color = UIImage imageWithColor
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    self.searchBar.delegate = self;
    mapView_.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeNormal;
    
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:0];
    
    [self.view insertSubview:mapView_ atIndex:0];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSLog(@"before if");
    if (!updatedLocation_) {
            NSLog(@"in if");
        updatedLocation_ = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        mapView_.camera = [GMSCameraPosition cameraWithTarget:location.coordinate zoom:14];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *resourceURL = [[NSBundle mainBundle] pathForResource:@"GooglePlacesExample" ofType:@"json"];
    NSLog(@"%@", resourceURL);
    NSData *jsonData = [NSData dataWithContentsOfFile:resourceURL];
    
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", myString);
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
    myArray = [Place parseJSONIntoPlaces:jsonData];
    Place *testPlace = myArray[0];
    NSLog(@"The name of the first place is %@",testPlace.name);
}

//-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
//    UIView *infoWindow = [[UIView alloc] init];
//    infoWindow.frame = CGRectMake(0, 0, 200, 70);
//    infoWindow.backgroundColor = [UIColor grayColor];
//    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.frame = CGRectMake(14, 11, 175, 16);
//    [infoWindow addSubview:titleLabel];
//    titleLabel.text = marker.title;
//    return  infoWindow;
//}

//- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
//    NSLog(@"Tapped!");
//}

@end