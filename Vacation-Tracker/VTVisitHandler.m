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

- (void)addVisit:(LKVisit *)visit {
    if (_visits == nil) {
        _visits = [[NSMutableArray alloc] init];
    }
    [_visits addObject:visit];
    [VTVisitHandler notifyChange:_visits];
}

- (void)removeVisitAtIndex:(NSUInteger)index {
    [_visits removeObjectAtIndex:index];
    [VTVisitHandler notifyChange:_visits];
}

- (NSMutableArray *)visits {
    return _visits;
}

@end
