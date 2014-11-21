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
    
    NSURL *urlWithSearchTerm = [NSURL URLWithString:[NSString stringWithFormat:@"https://work-wherever.herokuapp.com/google/inj/&location=%f,%f&radius=%i&name=%@",latitude, longitude, radius, searchTerm]];
    
    NSURLSessionConfiguration *configuruation = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession = [NSURLSession sessionWithConfiguration:configuruation];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlWithSearchTerm];
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
                if (httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode <= 299) {
                    NSLog(@"success! code: %lu", httpURLResponse.statusCode);
                    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"%@", json);
                    NSMutableArray *places = [Place parseJSONIntoPlaces:data];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{completionHandler(nil,places);
                    }];
                }
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