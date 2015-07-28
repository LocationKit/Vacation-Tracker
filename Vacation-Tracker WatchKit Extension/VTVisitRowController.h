//
//  VTVisitRowController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/23/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface VTVisitRowController : NSObject

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *visitLabel;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *timeLabel;

@end
