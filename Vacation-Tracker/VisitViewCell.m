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
    
    // Place name
    if (placeName == nil) {
        placeName = [visit place].venue.name;
        
        LKAddress *address = visit.place.address;
        NSArray *streetName = [address.streetName componentsSeparatedByString:@" "];
        
        NSString *name = address.streetNumber;
        for (int x = 0; x < [streetName count]; x++) {
            NSString *currentComponent = [streetName objectAtIndex:x];
            // If the component contains a number, ('19th' for example) it should be lowercase.
            if ([currentComponent intValue] != 0) {
                name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] lowercaseString]];
            }
            else {
                // If the component has length one, or is equal to NE, NW, SE, or SW it should be uppercase.
                if ([currentComponent length] == 1 || [currentComponent isEqualToString:@"NE"] || [currentComponent isEqualToString:@"NW"] || [currentComponent isEqualToString:@"SE"] || [currentComponent isEqualToString:@"SW"]) {
                    name = [name stringByAppendingFormat:@" %@", [currentComponent uppercaseString]];
                }
                // Otherwise it should simply be capitalized.
                else {
                    name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] capitalizedString]];
                }
            }
        }
        [_placeName setText:name];
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
    NSTimeInterval difference = [[NSDate date] timeIntervalSinceDate:[visit arrivalDate]];  // Difference between now and the arrival date
    difference -= fmod(difference, 86400.0); // Number of seconds to the day of the arrival date
    difference /= 86400.0;                   // Number of days (86400 seconds in 1 day)
    if (difference < 1.0 && difference >= 0.0) {
        [_date setText:@"Today"];
    }
    
    else if (difference < 2.0 && difference >= 1.0) {
        [_date setText:@"Yesterday"];
    }
    
    else if (difference < 8.0 && difference >= 2.0) {
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
