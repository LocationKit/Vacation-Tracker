//
//  VTTripHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripHandler.h"

NSString *const VTVisitsChangedNotification = @"VTTripsChangedNotification";

@implementation VTTripHandler

static NSMutableArray *trips;

+ (void)registerObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTTripsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

+ (void)addTrip:(VTTrip *)trip {
    [trips addObject:trip];
}

+ (void)removeTripAtIndex:(NSUInteger)index {
    
}

+ (NSMutableArray *)trips {
    return trips;
}

@end
