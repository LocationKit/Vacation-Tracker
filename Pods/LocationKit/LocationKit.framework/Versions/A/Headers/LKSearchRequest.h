//
// Created by SocialRadar on 6/16/15.
// Copyright (c) 2015 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LKSearchRequest : NSObject

/*
 *  location
 *
 *  Discussion:
 *      Uses most recent location if not assigned
 *
 */
@property(nonatomic, strong) CLLocation *location;

/*
 *  radius
 *
 *  Discussion:
 *      Default is 1000 m
 *
 */
@property(nonatomic) CLLocationDistance radius;

/*
 *  limit
 *
 *  Discussion:
 *      Default is 1000
 *
 */
@property(nonatomic) NSUInteger limit;



- (instancetype)initWithLocation:(CLLocation *)location;

+ (instancetype)requestWithLocation:(CLLocation *)location;


@end