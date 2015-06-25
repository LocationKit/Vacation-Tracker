//
//  VTTripListViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTTripHandler.h"

@interface VTTripListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
