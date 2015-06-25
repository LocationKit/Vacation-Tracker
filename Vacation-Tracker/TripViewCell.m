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
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if ([trip tripName] == nil) {
        [_tripNameLabel setText:@"Unknown Location"];
    }
    else {
        [_tripNameLabel setText:[trip tripName]];
    }
}

@end
