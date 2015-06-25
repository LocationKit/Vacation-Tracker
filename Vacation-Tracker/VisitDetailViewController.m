//
//  VisitDetailViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitDetailViewController.h"

#define MILE_TO_METER 0.00062137f

@interface VisitDetailViewController ()

@end

NSString *placeName;

@implementation VisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    placeName = [_visit place].venue.name;
    
    [self addAnnotation];
    
    if (placeName == nil) {
        [_locationLabel setText:@"Unregistered Place"];
    }
    else {
        [_locationLabel setText:placeName];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"MM/dd/yyyy";
    NSString *dateString = [dateFormatter stringFromDate:[_visit arrivalDate]];
    [_dateLabel setText:dateString];
    
    dateFormatter.dateFormat = @"h:mm a";
    dateString = [dateFormatter stringFromDate: [_visit arrivalDate]];
    [_timeLabel setText:dateString];
    
    [_localityLabel setText:_visit.place.address.locality];
    // Do any additional setup after loading the view.
}

- (void)addAnnotation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    if (placeName == nil) {
        [annotation setTitle:@"Unregistered Place"];
    }
    else {
        [annotation setTitle:placeName];
    }
    [annotation setCoordinate:_visit.place.address.coordinate];
    [_mapView setCenterCoordinate:annotation.coordinate];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance([_mapView centerCoordinate], 1.0f / MILE_TO_METER, 1.0f / MILE_TO_METER)];
    [_mapView addAnnotation:annotation];
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
