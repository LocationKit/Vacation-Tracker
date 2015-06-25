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

@implementation VTLKDelegate

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    NSLog(@"Location update.");
    
    // For debug only!!! Gets the place and inits a visit with that place.
    [[LocationKit sharedInstance] getCurrentPlaceWithHandler:^(LKPlace *place, NSError *error) {
        if (error == nil && location != nil && place != nil) {
            NSLog(@"User is in %@", place.venue.name);
            LKVisit *visit = [[LKVisit alloc] init];
            [visit setPlace:place];
            if (visit.place.venue.name != nil) {
                [VTTripHandler addVisit:visit forTrip:[[VTTrip alloc] initWithName:visit.place.address.locality]];
            }
        }
    }];
}

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit {
    NSLog(@"Visit started.");
    [VTTripHandler addVisit:visit forTrip:[[VTTrip alloc] initWithName:visit.place.address.locality]];
}

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(LKVisit *)visit {
    NSLog(@"Visit ended.");
}

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error {
    NSLog(@"LocationKit failed with error: %@", error);
}

@end
