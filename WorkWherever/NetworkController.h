//
//  NetworkController.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/18/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Places.h"
#import "Constants.h"

@interface NetworkController : NSObject
@property (strong, nonatomic) NSURLSession *urlSession;

- (void) fetchPlacesWithSearchTerm:(NSString *)searchTerm completionHandler: (void(^)(NSError *error, NSMutableArray *places))completionHandler;
+ (id) networkController;

@end
