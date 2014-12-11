//
//  NetworkController.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/18/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "Constants.h"

@interface NetworkController : NSObject
@property (strong, nonatomic) NSURLSession *urlSession;

- (void) fetchPlacesWithSearchTerm:(NSString *)searchTerm withLatitude: (double) latitude andLongitude: (double) longitude andRadius: (int) radius completionHandler: (void(^)(NSError *error, NSMutableArray *places))completionHandler;
- (void) postLocationWifiInformationWithPlace:(Place *) place completionHandler: (void(^)(NSError *error, NSData *jsonData))completionHandler;
+ (id) networkController;

@end
