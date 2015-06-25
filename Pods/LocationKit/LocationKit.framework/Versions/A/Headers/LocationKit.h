//
// Created by SocialRadar
// Copyright (c) 2015 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "LKVisit.h"
#import "LKSearchRequest.h"

UIKIT_EXTERN NSString *const LKUserValueIdentifier;
UIKIT_EXTERN NSString *const LKUserValueName;
UIKIT_EXTERN NSString *const LKUserValueGender;
UIKIT_EXTERN NSString *const LKUserValueAge;
UIKIT_EXTERN NSString *const LKUserValueIncome;
UIKIT_EXTERN NSString *const LKUserValueOccupation;
UIKIT_EXTERN NSString *const LKUserValueMaritalStatus;
UIKIT_EXTERN NSString *const LKUserValueHasInAppPurchases;
UIKIT_EXTERN NSString *const LKUserValueInAppPurchaseTotal;
UIKIT_EXTERN NSString *const LKUserValueDateInstalled;


@protocol LocationKitDelegate;


@interface LocationKit : NSObject

@property(nonatomic, readonly) BOOL isRunning;

@property(nonatomic) NSTimeInterval callbackInterval;

@property(nonatomic, strong) NSTimer *scheduledLocationTimer;


+ (LocationKit *)sharedInstance;

- (instancetype) init __attribute__((unavailable("init not available")));


- (void)startWithApiToken:(NSString *)token andDelegate:(id <LocationKitDelegate>)delegate;

- (void)startWithApiToken:(NSString *)token withTimeInterval:(NSTimeInterval)timeInterval andDelegate:(id <LocationKitDelegate>)delegate;


- (void)getCurrentPlaceWithHandler:(void (^)(LKPlace *place, NSError *error))handler;

- (void)getPlaceForLocation:(CLLocation *)location withHandler:(void (^)(LKPlace *place, NSError *error))handler;

- (void)getCurrentLocationWithHandler:(void (^)(CLLocation *location, NSError *error))handler;


/*
*  searchForPlacseWithRequest:completionHandler:
*
*  Discussion:
*       Will return places ...
*
*/
- (void)searchForPlacseWithRequest:(LKSearchRequest *)request completionHandler:(void (^)(NSArray *places, NSError *error))handler;


/*
 *  updateUserValues:
 *
 *  Discussion:
 *      Update user values. Use LKUserValue constants as dictionary keys.
 *
 */
- (void)updateUserValues:(NSDictionary *)userValues;


- (void)pause;

- (NSError *)resume;


@end


@protocol LocationKitDelegate <NSObject>

@optional

- (void)locationKit:(LocationKit *)locationKit didUpdateLocation:(CLLocation *)location;

- (void)locationKit:(LocationKit *)locationKit didEndVisit:(LKVisit *)visit;

- (void)locationKit:(LocationKit *)locationKit didStartVisit:(LKVisit *)visit;

- (void)locationKit:(LocationKit *)locationKit didFailWithError:(NSError *)error;

@end