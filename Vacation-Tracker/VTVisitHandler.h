//
//  VTVisitHandler.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocationKit/LocationKit.h>

@interface VTVisitHandler : NSObject

extern NSString * const VTVisitsChangedNotification;

+ (void)registerObserver:(void (^)(NSNotification *))block;

+ (void)addVisitWithPlace:(LKPlace *)place Location:(CLLocation *)location;

+ (NSMutableArray *)visits;

@end
