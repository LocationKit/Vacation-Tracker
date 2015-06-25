//
//  VTTripHandler.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTrip.h"

@interface VTTripHandler : NSObject

extern NSString * const VTTripsChangedNotification;

+ (void)registerObserver:(void (^)(NSNotification *))block;

+ (void)addTrip:(VTTrip *)trip;

+ (void)removeTripAtIndex:(NSUInteger)index;

+ (NSMutableArray *)trips;

@end
