//
//  VTTrip.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTVisitHandler.h"

@class VTTrip;

@interface VTTrip : NSObject <NSCoding>

@property (strong, nonatomic) NSString *tripName;

@property (strong, nonatomic) VTVisitHandler *visitHandler;

- (instancetype)initWithName:(NSString *)name;

- (void)addVisit:(VTVisit *)visit;

@end
