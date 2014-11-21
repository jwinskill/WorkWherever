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
//    CLLocation *myLocation;
    BOOL updatedLocation_;
}

- (void)viewDidLoad {
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    self.searchBar.delegate = self;
    mapView_.delegate = self;
    [locationManager requestAlwaysAuthorization];
    
    self.myLocation = [mapView_ myLocation];
    NSLog(@"%f, %f", self.myLocation.coordinate.latitude, self.myLocation.coordinate.longitude);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.myLocation.coordinate.latitude longitude:self.myLocation.coordinate.longitude zoom:4];
    [mapView_ animateToLocation:self.myLocation.coordinate];
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeNormal;
    
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:0];
    mapView_.delegate = self;
    [self.view insertSubview:mapView_ atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:0];
    mapView_.myLocationEnabled = YES;
    [mapView_ setNeedsDisplay];
    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"]) {
            NSLog(@"in if");
            updatedLocation_ = YES;
            self.myLocation = [change objectForKey:NSKeyValueChangeNewKey];
            mapView_.camera = [GMSCameraPosition cameraWithTarget:self.myLocation.coordinate zoom:15];
            [mapView_ setNeedsDisplay];
            [mapView_ removeObserver:self forKeyPath:@"myLocation"];
    }
     else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [mapView_ clear];
    
    [[NetworkController networkController] fetchPlacesWithSearchTerm:searchBar.text withLatitude:self.myLocation.coordinate.latitude andLongitude:self.myLocation.coordinate.longitude andRadius:300 completionHandler:^(NSError *error, NSMutableArray *places) {
        if (error != nil) {
            NSLog(@"%@", error.description);
        }
        self.places = places;
        for (Place *place in self.places) {
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.latitude, place.longitude);
            PlaceMarker *marker = [PlaceMarker markerWithPosition:position];
            marker.place = place;
            marker.title = place.name;
            marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = mapView_;
        }
        [searchBar resignFirstResponder];
    }];


    
//    NSString *resourceURL = [[NSBundle mainBundle] pathForResource:@"GooglePlacesExample" ofType:@"json"];
//    NSLog(@"%@", resourceURL);
//    NSData *jsonData = [NSData dataWithContentsOfFile:resourceURL];
//    
//    NSString *myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", myString);
//    self.places = [Place parseJSONIntoPlaces:jsonData];
    
    
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(PlaceMarker *)marker {
    InfoWindow *window = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    window.name.text = marker.title;
    window.ratingView.canEdit = NO;
    window.ratingView.maxRating = 5;
    window.ratingView.rating = marker.place.rating;
    return window;
}

-(void)viewWillDisappear:(BOOL)animated {
    
}


@end