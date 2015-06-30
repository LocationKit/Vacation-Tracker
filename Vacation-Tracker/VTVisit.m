//
//  VTVisit.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/30/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisit.h"

@implementation VTVisit

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setArrivalDate:[aDecoder decodeObjectForKey:@"self.arrivalDate"]];
        [self setDepartureDate:[aDecoder decodeObjectForKey:@"self.departureDate"]];
        [self setPlace:[aDecoder decodeObjectForKey:@"self.place"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self arrivalDate] forKey:@"self.arrivalDate"];
    [aCoder encodeObject:[self departureDate] forKey:@"self.departureDate"];
    [aCoder encodeObject:[self place] forKey:@"self.place"];
}

@end
