//
//  VTTrip.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocationKit/LocationKit.h>
#import "VTVisitHandler.h"


@class VTTrip;

@interface VTTrip : NSObject

@property (strong, nonatomic) NSString *tripName;

@property (strong, nonatomic) VTVisitHandler *visitHandler;

- (void)initWithName:(NSString *)name;

- (void)addVisit:(LKVisit *)visit;

@end
