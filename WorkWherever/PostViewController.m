//
//  PostViewController.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/20/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController (){
    Reachability *internetReachableFoo;
}
@end

@implementation PostViewController 

- (void)viewDidLoad {
    
    self.locationPicker.dataSource = self;
    self.locationPicker.delegate = self;

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.placesNearby.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *tView = (UILabel *)view;
    if (!tView) {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:21]];
        tView.textAlignment = NSTextAlignmentCenter;
        Place *place = self.placesNearby[row];
        tView.text = place.name;
        return tView;
    }
    return nil;
}

// Checks if we have an internet connection or not
//- (void)testInternetConnection
//{
//    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
//    
//    // Internet is reachable
//    internetReachableFoo.reachableBlock = ^(Reachability*reach)
//    {
//        // Update the UI on the main thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Yayyy, we have the interwebs!");
//        });
//    };
//    
//    // Internet is not reachable
//    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
//    {
//        // Update the UI on the main thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"Someone broke the internet :(");
//        });
//    };
//    
//    [internetReachableFoo startNotifier];
//}

- (IBAction)postButtonPressed:(id)sender {
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi)
    {
        //WiFi
        NSLog(@"We're currently on wifi");
        //TODO: - add WKWebView for POST
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Connect to wifi" message:@"In order to post wifi information for current work environment, please connect to the wifi network." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}

@end
