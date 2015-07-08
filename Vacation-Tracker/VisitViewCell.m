//
//  VisitViewCell.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitViewCell.h"

#define DAY 86400.0f

@implementation VisitViewCell

- (void)setVisit:(VTVisit *)visit {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];    // Adds a '>' on the right side of the cell
    
    NSString *placeName = [visit place].venue.name;
    
    // Place name
    if (placeName == nil) {
        [_placeName setText:@"Unknown Place"];
    }
    else {
        [_placeName setText:[visit place].venue.name];
    }
    
    // Time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    
    NSString *dateString = [dateFormatter stringFromDate: [visit arrivalDate]];
    [_time setText:dateString];
    
    // Date
    NSTimeInterval difference = [[NSDate date] timeIntervalSinceDate:[visit arrivalDate]];
    if (difference < DAY && difference >= 0) {
        [_date setText:@"Today"];
    }
    
    else if (difference < (2.0f * DAY) && difference >= DAY) {
        [_date setText:@"Yesterday"];
    }
    
    else if (difference < (8.0f * DAY) && difference >= (2.0f * DAY)) {
        dateFormatter.dateFormat = @"EEEE";
        [_date setText:[NSString stringWithFormat:@"Last %@", [dateFormatter stringFromDate:[visit arrivalDate]]]];
    }
    
    else {
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        dateString = [dateFormatter stringFromDate:[visit arrivalDate]];
        [_date setText:dateString];
    }
}

@end
