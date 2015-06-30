//
//  VTTrip.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTrip.h"

@implementation VTTrip

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        if (name == nil) {
            _tripName = @"Unknown Location";
        }
        else {
            _tripName = [name capitalizedStringWithLocale:[NSLocale currentLocale]];
        }
    }
    return self;
}

- (void)addVisit:(LKVisit *)visit {
    if (_visitHandler == nil) {
        _visitHandler = [[VTVisitHandler alloc] init];
        [_visitHandler setTripName:_tripName];
    }
    [_visitHandler addVisit:visit];
}

@end
