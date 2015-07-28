//
//  VTMapInterfaceController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/28/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTMapInterfaceController.h"
#import "InterfaceController.h"

@interface VTMapInterfaceController ()

@end

@implementation VTMapInterfaceController

VTVisit *visit;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    visit = (VTVisit *)context;
    [_mapView addAnnotation:visit.place.address.coordinate withPinColor:WKInterfaceMapPinColorRed];
    [_mapView setRegion:MKCoordinateRegionMake(visit.place.address.coordinate, MKCoordinateSpanMake(.01, .01))];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



