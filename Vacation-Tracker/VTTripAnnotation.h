//
//  VTTripAnnotation.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/7/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VTTrip.h"

@interface VTTripAnnotation : MKPointAnnotation

@property (strong, nonatomic) VTTrip *trip;

- (id)initWithTrip:(VTTrip *)trip;

@end
