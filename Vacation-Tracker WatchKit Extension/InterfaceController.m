//
//  InterfaceController.m
//  Vacation-Tracker WatchKit Extension
//
//  Created by Spencer Atkin on 7/23/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "InterfaceController.h"

@interface InterfaceController()

@property NSArray *visits;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    //[self loadVisits];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self loadVisits];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)loadVisits {
    [WKInterfaceController openParentApplication:@{@"request":@"visits"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSData *replyData = [replyInfo objectForKey:@"trips"];
        if (replyData == nil) {
            [_tableView setNumberOfRows:1 withRowType:@"rowController"];
            VTVisitRowController *row = [_tableView rowControllerAtIndex:0];
            [row.visitLabel setText:@"No visits"];
            [row.timeLabel setText:nil];
            return;
        }
        NSObject *unarchivedData = [NSKeyedUnarchiver unarchiveObjectWithData:replyData];
        if (unarchivedData == 0 || [(NSArray *)unarchivedData count] == 0) {
            [_tableView setNumberOfRows:1 withRowType:@"rowController"];
            VTVisitRowController *row = [_tableView rowControllerAtIndex:0];
            [row.visitLabel setText:@"No visits"];
        }
        else {
            _visits = [[[(NSArray *)unarchivedData objectAtIndex:0] visitHandler] visits];
            
            [_tableView setNumberOfRows:[_visits count] withRowType:@"rowController"];
            NSInteger maxIndex = [_visits count] -  1;
            for (NSInteger x = 0; x < _tableView.numberOfRows; x++) {
                NSString *visitName = [[[[_visits objectAtIndex:maxIndex - x] place] venue] name];
                
                VTVisitRowController *row = [_tableView rowControllerAtIndex:x];
                [row.visitLabel setText:visitName];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"h:mm a";
                
                NSString *dateString = [dateFormatter stringFromDate: [[_visits objectAtIndex:maxIndex - x] arrivalDate]];
                [row.timeLabel setText:dateString];

            }
        }
    }];
    
    //NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.socialradar.VTSharedDefaults"];
    //return [NSKeyedUnarchiver unarchiveObjectWithData:[sharedDefaults objectForKey:@"trips"]];
}
- (IBAction)didTapRefresh {
    [self loadVisits];
}

@end



