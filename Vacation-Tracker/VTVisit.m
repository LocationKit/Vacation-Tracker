//
//  VTVisit.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisit.h"

@implementation VTVisit

+ (id)initWithPlace:(LKPlace *)place Location:(CLLocation *)location {
    VTVisit *tmp = [[VTVisit alloc] init];
    [tmp setPlace:place];
    [tmp setLocation:location];
    
    return tmp;
}

@end
