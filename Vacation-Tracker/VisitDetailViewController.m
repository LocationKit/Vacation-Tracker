//
//  VisitDetailViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitDetailViewController.h"

@interface VisitDetailViewController ()

@end

@implementation VisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_locationLabel setText:_visit.place.venue.name];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:[_visit arrivalDate]];
    [_dateLabel setText:dateString];
    
    dateFormatter.dateFormat = @"HH:mm";
    dateString = [dateFormatter stringFromDate: [_visit arrivalDate]];
    [_timeLabel setText:dateString];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
