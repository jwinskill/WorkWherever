//
//  ViewController.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/17/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioner = [[Transitioner alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    [locationManager startUpdatingLocation];
}

# pragma mark - Get current location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"current latitude: %f, current longitude: %f", self.location.coordinate.latitude, self.location.coordinate.longitude);
}

# pragma mark - prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MAPVIEW_SEGUE"]) {
        MapViewController *destinationVC = segue.destinationViewController;
        self.transitioner.rotatePointY = 0;
        self.transitioner.rotateAngleIn = -M_PI / 2;
        self.transitioner.rotateAngleOut = -M_PI / 2;
        destinationVC.transitioningDelegate = self.transitioner;
    } else if ([segue.identifier isEqualToString:@"WIFI_SEGUE"]) {
        PostViewController *destinationVC = segue.destinationViewController;
        self.transitioner.rotatePointY = destinationVC.view.frame.size.height;
        self.transitioner.rotateAngleIn = M_PI / 2;
        self.transitioner.rotateAngleOut = M_PI / 2;
        destinationVC.transitioningDelegate = self.transitioner;
        [[NetworkController networkController] fetchPlacesWithSearchTerm:nil withLatitude:self.location.coordinate.latitude andLongitude:self.location.coordinate.longitude andRadius:500 completionHandler:^(NSError *error, NSMutableArray *places) {
            destinationVC.placesNearby = places;
            [destinationVC.pickerView reloadAllComponents];
        }];
    }
}


- (IBAction)unwindToBaseController:(UIStoryboardSegue *)sender {
    
}


@end
