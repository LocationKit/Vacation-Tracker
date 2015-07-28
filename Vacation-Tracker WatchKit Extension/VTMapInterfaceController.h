//
//  VTMapInterfaceController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/28/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface VTMapInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;

@end
