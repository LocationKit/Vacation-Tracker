//
//  TripViewCell.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTTrip.h"

@interface TripViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tripNameLabel;

- (void)setTrip:(VTTrip *)trip;

@end
