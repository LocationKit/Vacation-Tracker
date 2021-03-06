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
#import "VTTripAnnotation.h"
#import "VTVisitAnnotation.h"

#define ZOOMED_IN _mapView.region.span.latitudeDelta < 4

@interface MapViewController ()

@property NSMutableArray *visits;

@property NSMutableDictionary *annotations; // Stores the annotation by their venueID.

@property MKUserTrackingBarButtonItem *trackingButton;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Adds the MKUserTrackingButton to the left side of the toolbar.
    _trackingButton = [[MKUserTrackingBarButtonItem alloc] initWithMapView:_mapView];
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:_toolbar.items];
    [items insertObject:_trackingButton atIndex:0];
    [_toolbar setItems:items];
    
    // Sets the settings button to a unicode gear icon.
    [_settingsButton setTitle:@"\u2699"]; // Unicode gear icon
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [_settingsButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    // Default setting is all trips
    _settingsPickerIndex = -1;
    
    // When trips are changed the map reloads annotations
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

// If a trip was tapped, the list of visits for that trip is shown.  If a visit was tapped, info about the visit is shown.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([[view annotation] isKindOfClass:[VTTripAnnotation class]]) {
        [self performSegueWithIdentifier:@"MapToVisitsID" sender:view];
    }
    else if ([[view annotation] isKindOfClass:[VTVisitAnnotation class]]){
        [self performSegueWithIdentifier:@"MapToVisitDetailID" sender:view];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    else {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"VisitAnnotationID"];
        if (annotationView) {
            [annotationView setAnnotation:annotation];
        }
        else {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"VisitAnnotationID"];
        }
        [annotationView setCanShowCallout:YES];
        [annotationView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
        return annotationView;
    }
    return nil;
}

// Changes the visibility of the annotations
- (IBAction)changeVisitVisibility:(id)sender {
    // If the annotations are not showing, add them
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Show Visits"]) {
        [_visitsButton setTitle:@"Hide Visits" forState:UIControlStateNormal];
        [self addAnnotations];
    }
    
    // If the annotations are showing, remove them
    else if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        [_visitsButton setTitle:@"Show Visits" forState:UIControlStateNormal];
        [self removeVisitsFromMap];
    }
}

// Adds the appropriate annotations to the map
- (void)addAnnotations {
    if ([_displayPrefs selectedSegmentIndex] == 1) {
        _annotations = [[NSMutableDictionary alloc] init];
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
    else {
        [self showTripsOnMap];
    }
}

// Places the appropriate trip/trips on the map
- (void)showTripsOnMap {
    // If the setting is set to "all" then all the trips are shown.
    if (_settingsPickerIndex == -1) {
        for (NSUInteger x = 0; x < [[VTTripHandler trips] count]; x++) {
            if ([[[[[VTTripHandler trips] objectAtIndex:x] visitHandler] visits] count] != 0) {
                VTTripAnnotation *annotation = [[VTTripAnnotation alloc] initWithTrip:[[VTTripHandler trips] objectAtIndex:x]];
                [annotation setTitle:[[VTTripHandler tripNames] objectAtIndex:x]];
                [annotation setSubtitle:[NSString stringWithFormat:@"%lu visits", (unsigned long)[[[[[VTTripHandler trips] objectAtIndex:x] visitHandler] visits] count]]];
                [annotation setCoordinate:((VTVisit *)[[[[[VTTripHandler trips] objectAtIndex:x] visitHandler] visits] objectAtIndex:0]).place.address.coordinate];
                [_mapView addAnnotation:annotation];
            }
        }
    }
    // Otherwise, only the selected trip is shown.
    else {
        VTTripAnnotation *annotation = [[VTTripAnnotation alloc] initWithTrip:[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex]];
        [annotation setTitle:[[VTTripHandler tripNames] objectAtIndex:_settingsPickerIndex]];
        [annotation setSubtitle:[NSString stringWithFormat:@"%lu visits", (unsigned long)[[[[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex] visitHandler] visits] count]]];
        [annotation setCoordinate:((VTVisit *)[[[[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex] visitHandler] visits] objectAtIndex:0]).place.address.coordinate];
        [_mapView addAnnotation:annotation];
    }
}

// Places all the visits in a certain trip.
- (void)showAllVisitsForTrip:(VTTrip *)trip {
    for (NSUInteger i = 0; i < [[[trip visitHandler] visits] count]; i++) {
        VTVisit *visit = [[[trip visitHandler] visits] objectAtIndex:i];
        NSString *placeName = visit.place.venue.name;
        NSString *uID = visit.place.venue.venueId;
        
        // If the place is not already shown, a new pin is dropped.
        if ([[_annotations allKeys] indexOfObject:uID] == NSNotFound) {
            VTVisitAnnotation *annotation = [[VTVisitAnnotation alloc] initWithVisit:visit];
            // If there is no valid venue name, set the title to the address
            if (placeName == nil) {
                LKAddress *address = visit.place.address;
                NSArray *streetName = [address.streetName componentsSeparatedByString:@" "];
                
                NSString *name = address.streetNumber;
                for (int x = 0; x < [streetName count]; x++) {
                    NSString *currentComponent = [streetName objectAtIndex:x];
                    // If the component contains a number, ('19th' for example) it should be lowercase.
                    if ([currentComponent intValue] != 0) {
                        name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] lowercaseString]];
                    }
                    else {
                        // If the component has length one, or is equal to NE, NW, SE, or SW it should be uppercase.
                        if ([currentComponent length] == 1 || [currentComponent isEqualToString:@"NE"] || [currentComponent isEqualToString:@"NW"] || [currentComponent isEqualToString:@"SE"] || [currentComponent isEqualToString:@"SW"]) {
                            name = [name stringByAppendingFormat:@" %@", [currentComponent uppercaseString]];
                        }
                        // Otherwise it should simply be capitalized.
                        else {
                            name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] capitalizedString]];
                        }
                    }
                }
                [annotation setTitle:name];
            }
            // If the name is valid, set it as the title.
            else {
                [annotation setTitle:placeName];
                [_annotations setObject:annotation forKey:uID];
            }
            [annotation increaseVisits:1];
            [annotation setCoordinate:visit.place.address.coordinate];
            [_mapView addAnnotation:annotation];
        }
        // If the place is already shown, simply increase the visits to that place.
        else {
            [[_annotations objectForKey:uID] increaseVisits:1];
        }
    }
}

// Removes all annotations from the map (except for the userLocation dot).
- (void)removeVisitsFromMap {
    id userLocation = [_mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[_mapView annotations]];
    
    if (userLocation != nil) {
        [pins removeObject:userLocation];
    }
    [_mapView removeAnnotations:pins];
}

// Reloads the map's annotations.
- (void)reloadAnnotations {
    // If the annotations are showing, remove them, then add them.
    // If they are not showing, there is nothing to be done.
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        [self removeVisitsFromMap];
        [self addAnnotations];
    }
}

// When the settings button is tapped, takes the user to the settings page.
- (IBAction)didTapSettings:(id)sender {
    [self performSegueWithIdentifier:@"ShowMapSettingsID" sender:self];
}

- (IBAction)didTapDisplayPrefs:(id)sender {
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        [self removeVisitsFromMap];
        [self addAnnotations];
    }
}

// Displays an alert that allows the user to type in a search term.
- (IBAction)didTapSearch:(id)sender {
    [self performSegueWithIdentifier:@"NearbyPlacesSegueID" sender:self];
}

- (IBAction)didTapMark:(id)sender {
    UIAlertController *locating = [UIAlertController alertControllerWithTitle:@"Locating..." message:@"Finding your current location." preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:locating animated:YES completion:nil];
    [[LocationKit sharedInstance] getCurrentPlaceWithHandler:^(LKPlace *place, NSError *error) {
        if (error == nil && place != nil) {
            NSLog(@"User is in %@ (manual)", place.venue.name);
            VTVisit *visit = [[VTVisit alloc] init];
            [visit setPlace:place];
            [visit setArrivalDate:[NSDate date/*WithTimeIntervalSince1970:0*/]]; // Placeholder time
            [VTTripHandler addVisit:visit forTrip:[[VTTrip alloc] initWithName:visit.place.address.locality]];
            [locating dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [locating dismissViewControllerAnimated:YES completion:^{
                [self showErrorAlertWithMessage:@"Could not determine your current place."];
            }];
            
        }
    }];
}

- (void)showErrorAlertWithMessage:(NSString *)message {
    UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *accept = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [error addAction:accept];
    [error.view setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [self presentViewController:error animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Segue to the map settings.
    if ([[segue identifier] isEqualToString:@"ShowMapSettingsID"]) {
        [[[[segue destinationViewController] viewControllers] objectAtIndex:0] setSelectedRow:[sender settingsPickerIndex] fromSender:self];
    }
    // Segue to a given trip's visits.
    else if ([[segue identifier] isEqualToString:@"MapToVisitsID"]) {
        [[segue destinationViewController] setTrip:[[sender annotation] trip]];
    }
    // Segue to a visit's info.
    else if ([[segue identifier] isEqualToString:@"MapToVisitDetailID"]) {
        [[segue destinationViewController] setVisit:[[sender annotation] visit]];
    }
}


@end
