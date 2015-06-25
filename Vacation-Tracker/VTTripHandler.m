//
//  VTTripHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripHandler.h"

NSString *const VTTripsChangedNotification = @"VTTripsChangedNotification";

NSString *const VTVisitsChangedNotification = @"VTVisitsChangedNotification";

@implementation VTTripHandler

static NSMutableArray *trips;
static NSMutableArray *tripNames;

// Register an observer for trip changes
+ (void)registerTripObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTTripsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

// Register an observer for visit changes
+ (void)registerVisitObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTVisitsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

+ (void)notifyTripChange:(NSArray *)trips {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTTripsChangedNotification object:trips];
}

+ (void)notifyVisitChange:(NSArray *)data {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTVisitsChangedNotification object:data];
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
    }
    NSUInteger lastIndex = [trips count] - 1;
    VTTrip *mostRecentTrip = [trips objectAtIndex:lastIndex];
    
    [mostRecentTrip addVisit:visit];
    [trips setObject:mostRecentTrip atIndexedSubscript:lastIndex];
    [VTTripHandler notifyTripChange:trips];
}

+ (NSMutableArray *)trips {
    return trips;
}

@end
