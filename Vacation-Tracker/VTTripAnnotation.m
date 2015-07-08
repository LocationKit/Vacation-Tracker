//
//  VTTripAnnotation.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/7/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripAnnotation.h"

@implementation VTTripAnnotation

- (id)initWithTrip:(VTTrip *)trip {
    self = [super init];
    if (self) {
        [self setTrip:trip];
    }
    return self;
}

@end
