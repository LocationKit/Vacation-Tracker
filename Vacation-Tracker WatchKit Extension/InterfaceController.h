//
//  InterfaceController.h
//  Vacation-Tracker WatchKit Extension
//
//  Created by Spencer Atkin on 7/23/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "VTVisitRowController.h"
#import "VTTripHandler.h"

@interface InterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceTable *tableView;

@end
