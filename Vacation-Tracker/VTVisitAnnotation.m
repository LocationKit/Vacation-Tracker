//
//  VTVisitAnnotation.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/7/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisitAnnotation.h"

@implementation VTVisitAnnotation

- (id)initWithVisit:(VTVisit *)visit {
    self = [super init];
    if (self) {
        [self setVisit:visit];
        [self setNumbVisits:0];
    }
    return self;
}

- (void)increaseVisits:(int)numb {
    _numbVisits += 1;
    if (_numbVisits == 1) {
        [self setSubtitle:@"1 visit"];
    }
    else {
        [self setSubtitle:[NSString stringWithFormat:@"%d visits", _numbVisits]];
    }
}

@end
