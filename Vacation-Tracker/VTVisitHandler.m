//
//  VTVisitHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisitHandler.h"
#import "VTTripHandler.h"

@implementation VTVisitHandler

- (void)addVisit:(VTVisit *)visit {
    // If visits is null it must be initialized
    if (_visits == nil) {
        _visits = [[NSMutableArray alloc] init];
    }
    [_visits addObject:visit];
    [VTTripHandler notifyVisitChange:[[NSArray alloc] initWithObjects:_tripName, _visits, nil]];
}

- (void)removeVisitAtIndex:(NSUInteger)index {
    [_visits removeObjectAtIndex:index];
    [VTTripHandler notifyVisitChange:[[NSArray alloc] initWithObjects:_tripName, _visits, nil]];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setVisits:[aDecoder decodeObjectForKey:@"self.visits"]];
        [self setTripName:[aDecoder decodeObjectForKey:@"self.tripName"]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[self visits] forKey:@"self.visits"];
    [aCoder encodeObject:[self tripName] forKey:@"self.tripName"];
}

@end
