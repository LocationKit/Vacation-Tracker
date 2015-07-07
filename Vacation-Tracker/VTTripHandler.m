//
//  VTTripHandler.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripHandler.h"

NSString *const VTTripsChangedNotification = @"VTTripsChangedNotification";

NSString *const VTVisitsChangedNotification = @"VTVisitsChangedNotification";

@implementation VTTripHandler

static NSMutableArray *trips;
static NSMutableArray *tripNames;

// Register an observer for trip changes
+ (void)registerTripObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTTripsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

// Register an observer for visit changes
+ (void)registerVisitObserver:(void (^)(NSNotification *))block {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserverForName:VTVisitsChangedNotification
                        object:nil
                         queue:nil
                    usingBlock:block];
}

+ (void)notifyTripChange:(NSArray *)trips {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTTripsChangedNotification object:trips];
    [VTTripHandler saveTripData];
}

+ (void)notifyVisitChange:(NSArray *)data {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:VTVisitsChangedNotification object:data];
    [[[trips objectAtIndex:[tripNames indexOfObject:[data objectAtIndex:0]]] visitHandler] setVisits:[data objectAtIndex:1]];
    [VTTripHandler notifyTripChange:trips];
    [VTTripHandler saveTripData];
}

+ (void)addVisit:(VTVisit *)visit forTrip:(VTTrip *)trip {
    if (trips == nil) {
        trips = [[NSMutableArray alloc] init];
    }
    if (tripNames == nil) {
        tripNames = [[NSMutableArray alloc] init];
    }
    if ([tripNames indexOfObject:[trip tripName]] == NSNotFound) {
        [trips addObject:trip];
        [tripNames addObject:[trip tripName]];
        /*NSUInteger lastIndex = [trips count] - 1;
        VTTrip *mostRecentTrip = [trips objectAtIndex:lastIndex];
        
        [mostRecentTrip addVisit:visit];
        [trips setObject:mostRecentTrip atIndexedSubscript:lastIndex];*/
        [trip addVisit:visit];
    }
    else {
        NSInteger index = [tripNames indexOfObject:[trip tripName]];
        VTTrip *tripToUpdate = [trips objectAtIndex:index];
        [tripToUpdate addVisit:visit];
    }
    [VTTripHandler notifyTripChange:trips];
}

+ (NSMutableArray *)trips {
    return trips;
}

+ (NSMutableArray *)tripNames {
    return tripNames;
}

+ (NSString *)docsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = paths[0];
    return documentsDirectoryPath;//[documentsDirectoryPath stringByAppendingPathComponent:@"trips"];
}

+ (void)saveTripData {
    // Write trips
    [NSKeyedArchiver archiveRootObject:trips toFile:[[self docsPath] stringByAppendingPathComponent:@"trips"]];
    // Write trip names
    [NSKeyedArchiver archiveRootObject:tripNames toFile:[[self docsPath] stringByAppendingPathComponent:@"tripNames"]];
}

+ (void)loadTripData {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *tripPath = [[self docsPath] stringByAppendingPathComponent:@"trips"];
    NSString *namesPath = [[self docsPath] stringByAppendingPathComponent:@"tripNames"];
    
    if ([fm fileExistsAtPath:tripPath isDirectory:false]) {
        trips = [NSKeyedUnarchiver unarchiveObjectWithFile:tripPath];
    }
    
    if ([fm fileExistsAtPath:namesPath isDirectory:false]) {
        tripNames = [NSKeyedUnarchiver unarchiveObjectWithFile:namesPath];
    }
}

@end
