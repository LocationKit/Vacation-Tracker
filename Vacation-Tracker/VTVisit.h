//
//  VTVisit.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocationKit/LocationKit.h>

@interface VTVisit : NSObject

@property (strong, nonatomic) LKPlace *place;
@property (strong, nonatomic) CLLocation *location;

+ (id)initWithPlace:(LKPlace *)place Location:(CLLocation *)location;

@end
