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

// Delegate to handle LocationKit updates
@implementation VTLKDelegate

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    NSLog(@"Location update.");
    
    // Logs the current venue name and locality.
    [[LocationKit sharedInstance] getCurrentPlaceWithHandler:^(LKPlace *place, NSError *error) {
        if (error == nil) {
            NSLog(@"The user is in %@ in %@.", place.venue.name, place.address.locality);
        } else {
            NSLog(@"Error fetching place: %@", error);
        }
    }];
    
}

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit {
    NSLog(@"Visit started.");
    // When a visit starts, it is added to the database of visits.
    [VTTripHandler addVisit:[[VTVisit alloc] initWithLKVisit:visit] forTrip:[[VTTrip alloc] initWithName:visit.place.address.locality]];
}

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(VTVisit *)visit {
    NSLog(@"Visit ended.");
}

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error {
    NSLog(@"LocationKit failed with error: %@", error);
}

@end
