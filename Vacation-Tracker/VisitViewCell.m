//
//  VisitViewCell.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitViewCell.h"

@implementation VisitViewCell

- (void)setVisit:(VTVisit *)visit {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];    // Adds a '>' on the right side of the cell
    
    NSString *placeName = [visit place].venue.name;
    
    if (placeName == nil) {
        [_placeName setText:@"Unregistered Place"];
    }
    else {
        [_placeName setText:[visit place].venue.name];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    
    NSString *dateString = [dateFormatter stringFromDate: [visit arrivalDate]];
    [_time setText:dateString];
    
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    dateString = [dateFormatter stringFromDate:[visit arrivalDate]];
    [_date setText:dateString];    
}

@end
