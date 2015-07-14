//
//  VTVisit.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/30/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocationKit/LocationKit.h>

@interface VTVisit : NSObject <NSCoding>

// From LKVisit

@property (nonatomic, strong) NSDate *arrivalDate;

@property (nonatomic, strong) NSDate *departureDate;

@property (nonatomic, strong) LKPlace *place;

// New

@property (nonatomic) double rating;

@property (strong, nonatomic) NSString *comments;

- (id)init;

- (id)initWithLKVisit:(LKVisit *)visit;

@end
