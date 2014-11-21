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
    
    self.parkingData = [[NSArray alloc] initWithObjects:@"Abundant and free",
                                                       @"Abundant and paid",
                                                       @"Hard to find and free",
                                                       @"Hard to find and paid",
                                                       @"Impossible",
                                                       nil];
    
    [locationManager startUpdatingLocation];
}

# pragma mark - Get current location

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"current latitude: %f, current longitude: %f", self.location.coordinate.latitude, self.location.coordinate.longitude);
}

# pragma mark - segue methods

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
            destinationVC.parkingPicker.delegate = self;
            destinationVC.parkingPicker.dataSource = self;
            [destinationVC.locationPicker reloadAllComponents];
        }];
    }
}


- (IBAction)unwindToBaseController:(UIStoryboardSegue *)sender {
    
}

# pragma mark - UIPicker datasource/delegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.parkingData.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *tView = (UILabel *)view;
    if (!tView) {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:21]];
        tView.textAlignment = NSTextAlignmentCenter;
        NSString *parkingString = self.parkingData[row];
        tView.text = parkingString;
        return tView;
    }
    return nil;
}


@end
