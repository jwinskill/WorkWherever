//
//  NetworkController.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/18/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "NetworkController.h"

@implementation NetworkController

- (void) fetchPlacesWithSearchTerm:(NSString *)searchTerm withLatitude: (double) latitude andLongitude: (double) longitude andRadius: (int) radius completionHandler: (void(^)(NSError *error, NSMutableArray *places))completionHandler {
    NSURL *url = [[NSURL alloc] init];
    if (searchTerm) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://work-wherever.herokuapp.com/google/inj/&location=%f,%f&radius=%i&keyword=%@",latitude, longitude, radius, searchTerm]];
        NSLog(@"The url is: %@", url.description);
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://work-wherever.herokuapp.com/google/inj/&location=%f,%f&radius=%i&keyword=code",latitude, longitude, radius]];
    }
    
    NSURLSessionConfiguration *configuruation = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession = [NSURLSession sessionWithConfiguration:configuruation];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
                if (httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode <= 299) {
                    NSLog(@"success! code: %lu", httpURLResponse.statusCode);
                    NSMutableArray *places = [Place parseJSONIntoPlaces:data];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{completionHandler(nil,places);
                    }];
                }
            }
        }
    }];
    [dataTask resume];
}

- (void) postLocationWifiInformationWithPlace:(Place *) place completionHandler: (void(^)(NSError *error, NSData *jsonData))completionHandler {
    
    NSString *post = [NSString stringWithFormat:@"placeID=%@&parkingRating=3", place.identifier];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://work-wherever.herokuapp.com/api"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
            NSLog(@"response: %@", httpURLResponse.description);
            if (httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode <= 299) {
                NSLog(@"POST successful");
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{completionHandler(nil, data);
                }];
            }
        }
    }];
    [dataTask resume];
}

+ (id) networkController {
    static NetworkController *networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[self alloc] init];
    });
    return networkController;
}

@end