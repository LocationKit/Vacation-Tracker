//
//  TripViewCell.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "TripViewCell.h"

@implementation TripViewCell

- (void)setTrip:(VTTrip *)trip {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];    // Adds a '>' on the right side of the cell
    NSUInteger numVisits = [[[trip visitHandler] visits] count];
    if ([trip tripName] == nil) {
        [_tripNameLabel setText:@"Unknown Location"];
    }
    else {
        if (numVisits == 1) {
            [_tripNameLabel setText:[NSString stringWithFormat:@"%@ (%lu visit)", [trip tripName], (unsigned long)numVisits]];
        }
        
        else {
            [_tripNameLabel setText:[NSString stringWithFormat:@"%@ (%lu visits)", [trip tripName], (unsigned long)numVisits]];
        }
    }
}

@end
