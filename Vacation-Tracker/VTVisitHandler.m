//
//  VTVisitHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisitHandler.h"
//#import "VTVisit.h"


NSString *const VTVisitsChangedNotification = @"VTVisitsChangedNotification";

@implementation VTVisitHandler

static NSMutableArray *visits;

+ (void)registerObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTVisitsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

+ (void)notifyChange:(NSArray *)visits {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTVisitsChangedNotification object:visits];
}

/*+ (void)addVisitWithPlace:(LKPlace *)place Location:(CLLocation *)location {
    if (visits == nil) {
        visits = [[NSMutableArray alloc] init];
    }
    [visits addObject:[VTVisit initWithPlace:place Location:location]];
    [VTVisitHandler notifyChange:visits];
}*/

+ (void)adddVisit:(LKVisit *)visit {
    if (visits == nil) {
        visits = [[NSMutableArray alloc] init];
    }
    [visits addObject:visit];
    [VTVisitHandler notifyChange:visits];
}

+ (NSMutableArray *)visits {
    return visits;
}

@end
