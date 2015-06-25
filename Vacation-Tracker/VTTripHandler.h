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

extern NSString * const VTVisitsChangedNotification;

+ (void)registerTripObserver:(void (^)(NSNotification *))block;

+ (void)registerVisitObserver:(void (^)(NSNotification *))block;

+ (void)notifyVisitChange:(NSArray *)data;

+ (void)addVisit:(LKVisit *)visit forTrip:(VTTrip *)trip;

+ (NSMutableArray *)trips;

@end
