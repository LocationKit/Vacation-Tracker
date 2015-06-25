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

//extern NSString * const VTVisitsChangedNotification;

@property (strong, nonatomic) NSMutableArray *visits;

@property (strong, nonatomic) NSString *tripName;

- (void)addVisit:(LKVisit *)visit;

- (void)removeVisitAtIndex:(NSUInteger)index;

@end
