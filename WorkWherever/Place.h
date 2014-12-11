//
//  Places.h
//  WorkWherever
//
//  Created by Joshua Winskill on 11/18/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *identifier;
@property double latitude;
@property double longitude;
@property double rating;

- (instancetype) initWithName:(NSString *)name latitude: (double) latitude longitude: (double) longitude rating: (double) rating identifier: (NSString *)identifier;
+ (NSMutableArray *)parseJSONIntoPlaces:(NSData *)rawJSONData;

@end
