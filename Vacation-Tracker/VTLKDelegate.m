//
//  VTLKDelegate.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/23/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTLKDelegate.h"
#import "VTTripHandler.h"
#import "VTTrip.h"
#import "VTVisit.h"

@implementation VTLKDelegate

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    NSLog(@"Location update.");
}

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit {
    NSLog(@"Visit started.");
    [VTTripHandler addVisit:[[VTVisit alloc] initWithLKVisit:visit] forTrip:[[VTTrip alloc] initWithName:visit.place.address.locality]];
}

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(VTVisit *)visit {
    NSLog(@"Visit ended.");
}

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error {
    NSLog(@"LocationKit failed with error: %@", error);
}

@end
