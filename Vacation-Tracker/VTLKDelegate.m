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
    [[LocationKit sharedInstance] getCurrentPlaceWithHandler:^(LKPlace *place, NSError *error) {
        if (error == nil && location != nil && place != nil) {
            NSLog(@"User is in %@", place.venue.name);
            //[VTVisitHandler addVisitWithPlace:place Location:location];
        }
    }];
}

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit {
    NSLog(@"Visit added.");
    [VTVisitHandler adddVisit:visit];
}

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(LKVisit *)visit {
    
}

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error {
    
}

@end
