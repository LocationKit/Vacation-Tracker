//
// Created by SocialRadar on 6/10/15.
// Copyright (c) 2015 SocialRadar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKVenue.h"
#import "LKAddress.h"


@interface LKPlace : NSObject <NSCoding>

@property(nonatomic, strong) LKVenue *venue;
@property(nonatomic, strong) LKAddress *address;

@end