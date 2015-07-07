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
    }
    return self;
}

@end
