//
//  MapViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "MapViewController.h"
#import "VTTripHandler.h"
#import "VTVisit.h"

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
        //_visits = note.object;
        [self reloadAnnotations];
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeVisitVisibility:(id)sender {
    // If the annotations are not showing, add them
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Show All Visits"]) {
        [_visitsButton setTitle:@"Hide All Visits" forState:UIControlStateNormal];
        [self showVisitsOnMap];
    }
    
    // If the annotations are showing, remove them
    else if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide All Visits"]) {
        [_visitsButton setTitle:@"Show All Visits" forState:UIControlStateNormal];
        [self removeVisitsFromMap];
    }
}

- (void)showVisitsOnMap {
    // Loops through each visit for each trip and displays it on the map
    for (NSUInteger x = 0; x < [[VTTripHandler trips] count]; x++) {
        for (NSUInteger i = 0; i < [[[[[VTTripHandler trips] objectAtIndex:x] visitHandler] visits] count]; i++) {
            VTVisit *visit = [[[[[VTTripHandler trips] objectAtIndex:x] visitHandler] visits] objectAtIndex:i];
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            NSString *placeName = visit.place.venue.name;
            // If there is no valid venue name, set it to "Unregistered place"
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
    // If the annotations are showing, remove them, then add them.
    // If they are not showing, nothing to be done.
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide All Visits"]) {
        [self removeVisitsFromMap];
        [self showVisitsOnMap];
    }
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
