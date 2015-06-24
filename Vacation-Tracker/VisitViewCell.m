//
//  VisitViewCell.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitViewCell.h"

@implementation VisitViewCell

- (void)setVisit:(LKVisit *)visit {
    [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [_placeName setText:[visit place].venue.name];
    // SET DATE/TIME TEXT SOMEHOW
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    
    NSString *dateString = [dateFormatter stringFromDate: [visit arrivalDate]];
    [_time setText:dateString];
    
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    dateString = [dateFormatter stringFromDate:[visit arrivalDate]];
    [_date setText:dateString];    
}

@end
