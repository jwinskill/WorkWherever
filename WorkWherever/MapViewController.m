//
//  MapViewController.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/17/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController {
    GMSMapView *mapView_;
    CLLocationManager *locationManager;
    BOOL updatedLocation_;
}

- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    self.searchBar.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeNormal;
    
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:0];
    mapView_.delegate = self;
    [self.view insertSubview:mapView_ atIndex:0];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view reloadInputViews];
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
    [mapView_ clear];
    
    NSString *resourceURL = [[NSBundle mainBundle] pathForResource:@"GooglePlacesExample" ofType:@"json"];
    NSLog(@"%@", resourceURL);
    NSData *jsonData = [NSData dataWithContentsOfFile:resourceURL];
    
    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", myString);
    self.places = [Place parseJSONIntoPlaces:jsonData];
    
    for (Place *place in self.places) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.latitude, place.longitude);
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        //marker.place = place;
        marker.title = place.name;
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView_;
    }
    [searchBar resignFirstResponder];
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    InfoWindow *window = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    window.name.text = marker.title;
    return window;
}

-(void)viewWillDisappear:(BOOL)animated {
    
}


@end