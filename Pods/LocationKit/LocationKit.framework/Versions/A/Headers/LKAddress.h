//
// Created by SocialRadar on 6/3/15.
// Copyright (c) 2015 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LKAddress : NSObject <NSCoding>

@property(nonatomic, strong) NSString *addressId;
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, strong) NSString *geometryId;
@property(nonatomic, strong) NSString *coordinatesType;
@property(nonatomic, strong) NSString *country;
@property(nonatomic, strong) NSString *locality;
@property(nonatomic, strong) NSString *countryCode;
@property(nonatomic, strong) NSString *streetName;
@property(nonatomic, strong) NSString *streetNumber;
@property(nonatomic, strong) NSString *postalCode;
@property(nonatomic, strong) NSString *region;
@property NSUInteger venueCount;


@end