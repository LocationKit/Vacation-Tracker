//
//  VTTripHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripHandler.h"

NSString *const VTTripsChangedNotification = @"VTTripsChangedNotification";

@implementation VTTripHandler

static NSMutableArray *trips;
static NSMutableArray *tripNames;

+ (void)registerObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTTripsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

+ (void)notifyChange:(NSArray *)visits {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTVisitsChangedNotification object:visits];
}

+ (void)addVisit:(LKVisit *)visit forTrip:(VTTrip *)trip {
    if (trips == nil) {
        trips = [[NSMutableArray alloc] init];
    }
    if (tripNames == nil) {
        tripNames = [[NSMutableArray alloc] init];
    }
    if ([tripNames indexOfObject:[trip tripName]] == NSNotFound) {
        [trips addObject:trip];
        [tripNames addObject:[trip tripName]];
        NSLog(@"2");
    }
    NSUInteger lastIndex = [trips count] - 1;
    VTTrip *mostRecentTrip = [trips objectAtIndex:lastIndex];
    
    [mostRecentTrip addVisit:visit];
    [trips setObject:mostRecentTrip atIndexedSubscript:lastIndex];
    [VTTripHandler notifyChange:trips];
}

+ (NSMutableArray *)trips {
    return trips;
}

@end
