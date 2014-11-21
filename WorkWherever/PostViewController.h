//
//  PostViewController.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/20/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "Reachability.h"

@interface PostViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSMutableArray *placesNearby;
@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *parkingPicker;

- (IBAction)postButtonPressed:(id)sender;

@end
