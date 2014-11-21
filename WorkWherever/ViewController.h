//
//  ViewController.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/17/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Transitioner.h"
#import "MapViewController.h"
#import "PostViewController.h"
#import "NetworkController.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) Transitioner *transitioner;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSArray *parkingData;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)unwindToBaseController:(UIStoryboardSegue *)sender;

@end

