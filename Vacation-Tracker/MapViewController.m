//
//  MapViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "MapViewController.h"
#import "VTTripHandler.h"

@interface MapViewController ()

@property NSMutableArray *visits;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [VTTripHandler registerVisitObserver:^(NSNotification *note) {
        if(note.name != VTVisitsChangedNotification) {
            return;
        }
        _visits = note.object;
        [self reloadAnnotations];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeVisitVisibility:(id)sender {
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Show All Visits"]) {
        [_visitsButton setTitle:@"Hide All Visits" forState:UIControlStateNormal];
        [self showVisitsOnMap];
    }
    
    else if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide All Visits"]) {
        [_visitsButton setTitle:@"Show All Visits" forState:UIControlStateNormal];
        [self removeVisitsFromMap];
    }
}

- (void)showVisitsOnMap {
    //_visits = [VTVisitHandler visits];
    for (NSUInteger x = 0; x < [_visits count]; x++) {
        LKVisit *visit = [_visits objectAtIndex:x];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        NSString *placeName = visit.place.venue.name;
        if (placeName == nil) {
            [annotation setTitle:@"Unregistered Place"];
        }
        else {
            [annotation setTitle:placeName];
        }
        [annotation setCoordinate:visit.place.address.coordinate];
        [_mapView addAnnotation:annotation];
    }
}

- (void)removeVisitsFromMap {
    id userLocation = [_mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[_mapView annotations]];
    
    if (userLocation != nil) {
        [pins removeObject:userLocation];
    }
    [_mapView removeAnnotations:pins];
}

- (void)reloadAnnotations {
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide All Visits"]) {
        [self removeVisitsFromMap];
        [self showVisitsOnMap];
    }
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"Start locating user");
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
