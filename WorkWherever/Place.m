//
//  Places.m
//  WorkWherever
//
//  Created by Joshua Winskill on 11/18/14.
//  Copyright (c) 2014 Joshua Winskill. All rights reserved.
//

#import "Place.h"

@implementation Place

- (instancetype) initWithName:(NSString *)name latitude: (double) latitude longitude: (double) longitude rating: (double) rating identifier: (NSString *)identifier {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
        self.rating = rating;
        self.identifier = identifier;
    }
    return self;
}

+ (NSMutableArray *)parseJSONIntoPlaces:(NSData *)rawJSONData {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:rawJSONData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"json parsing unsuccessful. %@", error.localizedDescription);
    } else {
        NSArray *results = jsonDictionary[@"results"];
        for (NSDictionary *placeDictionary in results) {
            NSDictionary *geometry = placeDictionary[@"geometry"];
            NSDictionary *location = geometry[@"location"];
            NSString *latitudeString = location[@"lat"];
            double latitude = [latitudeString doubleValue];
            NSString *longitudeString = location[@"lng"];
            double longitude = [longitudeString doubleValue];
            NSString *name = placeDictionary[@"name"];
            NSString *ratingString = placeDictionary[@"rating"];
            double rating = [ratingString doubleValue];
            NSString *identifier = placeDictionary[@"id"];
            Place *newPlace = [[Place alloc] initWithName:name latitude:latitude longitude:longitude rating:rating identifier:identifier];
            [places addObject:newPlace];
        }
        return places;
    }
    return nil;
}

@end
