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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioner = [[Transitioner alloc] init];
}

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
        [NetworkController networkController] fet
    }
}

- (IBAction)unwindToBaseController:(UIStoryboardSegue *)sender {
    
}


@end
