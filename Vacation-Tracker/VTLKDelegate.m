//
//  VTLKDelegate.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/23/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTLKDelegate.h"
#import "VTVisitHandler.h"

@implementation VTLKDelegate

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location {
    NSLog(@"Location update.");
    [[LocationKit sharedInstance] getCurrentPlaceWithHandler:^(LKPlace *place, NSError *error) {
        if (error == nil && location != nil && place != nil) {
            NSLog(@"User is in %@", place.venue.name);
            LKVisit *visit = [[LKVisit alloc] init];
            [visit setPlace:place];
            if (visit.place.venue.name != nil) {
                [VTVisitHandler adddVisit:visit];
            }
            //[VTVisitHandler addVisitWithPlace:place Location:location];
        }
    }];
}

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit {
    NSLog(@"Visit started.");
    [VTVisitHandler adddVisit:visit];
}

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(LKVisit *)visit {
    NSLog(@"Visit ended.");
}

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error {
    
}

@end
