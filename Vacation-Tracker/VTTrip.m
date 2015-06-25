//
//  VTTrip.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTrip.h"

@implementation VTTrip

- (void)initWithName:(NSString *)name {
    _tripName = name;
}

- (void)addVisit:(LKVisit *)visit {
    if (_visitHandler == nil) {
        _visitHandler = [[VTVisitHandler alloc] init];
    }
    [_visitHandler addVisit:visit];
}

@end
