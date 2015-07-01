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
#import "MapSettingsViewController.h"

@interface MapViewController ()

@property NSMutableArray *visits;

@property NSMutableDictionary *annotations;
@property NSMutableDictionary *numbVisits;

@end

@implementation MapViewController

static BOOL state = YES; // debug only

- (void)viewDidLoad {
    [super viewDidLoad];
    _settingsPickerIndex = -1;
    [VTTripHandler registerTripObserver:^(NSNotification *note) {
        if(note.name != VTTripsChangedNotification) {
            return;
        }
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
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Show Visits"]) {
        [_visitsButton setTitle:@"Hide Visits" forState:UIControlStateNormal];
        [self showVisitsOnMap];
    }
    
    // If the annotations are showing, remove them
    else if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        [_visitsButton setTitle:@"Show Visits" forState:UIControlStateNormal];
        [self removeVisitsFromMap];
    }
}

- (void)showVisitsOnMap {
    _annotations = [[NSMutableDictionary alloc] init];
    _numbVisits = [[NSMutableDictionary alloc] init];
    // Loops through each visit for each trip and displays it on the map
    if (_settingsPickerIndex == -1) {
        for (NSUInteger x = 0; x < [[VTTripHandler trips] count]; x++) {
            [self showAllVisitsForTrip:[[VTTripHandler trips] objectAtIndex:x]];
        }
    }
    // Shows only one trip
    else {
        [self showAllVisitsForTrip:[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex]];
    }
}

- (void)showAllVisitsForTrip:(VTTrip *)trip {
    for (NSUInteger i = 0; i < [[[trip visitHandler] visits] count]; i++) {
        VTVisit *visit = [[[trip visitHandler] visits] objectAtIndex:i];
        NSString *placeName = visit.place.venue.name;
        NSString *uID = visit.place.venue.venueId;
        
        if ([[_annotations allKeys] indexOfObject:uID] == NSNotFound) {
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            // If there is no valid venue name, set it to "Unregistered place"
            if (placeName == nil) {
                [annotation setTitle:@"Unregistered Place"];
            }
            else {
                NSNumber *a = [[NSNumber alloc] initWithInt:1];
                [annotation setTitle:placeName];
                [_annotations setObject:annotation forKey:uID];
                [_numbVisits setObject:[a copy] forKey:uID];
            }
            [annotation setCoordinate:visit.place.address.coordinate];
            [_mapView addAnnotation:annotation];
        }
        else {
            NSNumber *b = [[NSNumber alloc] initWithInt:[[_numbVisits objectForKey:uID] intValue] + 1];
            [_numbVisits setObject:[b copy] forKey:uID];
            [[_annotations objectForKey:uID] setTitle:[NSString stringWithFormat:@"%@ (%d)", placeName, [b intValue]]];
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
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        [self removeVisitsFromMap];
        [self showVisitsOnMap];
    }
}

// debug only
- (IBAction)switchChanged:(id)sender {
    state = [sender isOn];
}


// debug only
+ (BOOL)debugSwitchState {
    return state;
}

- (IBAction)settingsTapped:(id)sender {
    [self performSegueWithIdentifier:@"ShowMapSettingsID" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowMapSettingsID"]) {
        [[segue destinationViewController] setSelectedRow:[sender settingsPickerIndex] fromSender:self];
    }
}


@end
