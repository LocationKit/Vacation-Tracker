//
//  VTListViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTVisitHandler.h"

@interface VTListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *visits;

@property (strong, nonatomic) NSString *tripName;

@end
