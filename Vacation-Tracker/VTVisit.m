//
//  VTVisit.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/30/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisit.h"

@implementation VTVisit

- (id)init {
    self = [super init];
    if (self) {
        [self setRating:5];
    }
    return self;
}

- (id)initWithLKVisit:(LKVisit *)visit {
    self = [super init];
    if (self) {
        [self setArrivalDate:[visit arrivalDate]];
        [self setDepartureDate:[visit departureDate]];
        [self setPlace:[visit place]];
        [self setRating:5];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setArrivalDate:[aDecoder decodeObjectForKey:@"self.arrivalDate"]];
        [self setDepartureDate:[aDecoder decodeObjectForKey:@"self.departureDate"]];
        [self setPlace:[aDecoder decodeObjectForKey:@"self.place"]];
        [self setRating:[aDecoder decodeDoubleForKey:@"self.rating"]];
        [self setComments:[aDecoder decodeObjectForKey:@"self.comments"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self arrivalDate] forKey:@"self.arrivalDate"];
    [aCoder encodeObject:[self departureDate] forKey:@"self.departureDate"];
    [aCoder encodeObject:[self place] forKey:@"self.place"];
    [aCoder encodeDouble:[self rating] forKey:@"self.rating"];
    [aCoder encodeObject:[self comments] forKey:@"self.comments"];
}

@end
