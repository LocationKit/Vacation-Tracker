//
//  VTTripHandler.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTTrip.h"
#import "VTVisit.h"

@interface VTTripHandler : NSObject

extern NSString * const VTTripsChangedNotification;

extern NSString * const VTVisitsChangedNotification;

+ (void)registerTripObserver:(void (^)(NSNotification *))block;

+ (void)registerVisitObserver:(void (^)(NSNotification *))block;

+ (void)notifyTripChange:(NSArray *)trips;

+ (void)notifyVisitChange:(NSArray *)data;

+ (void)addVisit:(VTVisit *)visit forTrip:(VTTrip *)trip;

+ (NSMutableArray *)trips;

+ (NSMutableArray *)tripNames;

+ (void)saveTripData;

+ (void)loadTripData;

@end
