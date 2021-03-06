//
//  VTVisitAnnotation.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/7/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "VTVisit.h"

@interface VTVisitAnnotation : MKPointAnnotation

@property (strong, nonatomic) VTVisit *visit;

@property (nonatomic) int numbVisits;

- (id)initWithVisit:(VTVisit *)visit;

- (void)increaseVisits:(int)numb;

@end
