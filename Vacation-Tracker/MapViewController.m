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

@property NSMutableDictionary *annotations;
@property NSMutableDictionary *numbVisits;

@end

@implementation MapViewController

static BOOL state = YES; // debug only
BOOL placedCorrectly = YES;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_settingsButton setTitle:@"\u2699"];
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [_settingsButton setTitleTextAttributes:dict forState:UIControlStateNormal];
    _settingsPickerIndex = -1;
    [VTTripHandler registerTripObserver:^(NSNotification *note) {
        if(note.name != VTTripsChangedNotification) {
            return;
        }
        [self reloadAnnotations];
        /*if (ZOOMED_IN) {
            // Update visits that were changed.
        }
        else {
            for (NSUInteger x = 0; x < [note.object count]; x++) {
                [[_annotations objectForKey:[[VTTripHandler tripNames] objectAtIndex:x]] setSubtitle:[NSString stringWithFormat:@"%ld visits", [[[[note.object objectAtIndex:x] visitHandler] visits] count]]];
                [_mapView removeAnnotation:[_annotations objectForKey:[[VTTripHandler tripNames] objectAtIndex:x]]];
            }
        }*/
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if ([[[_visitsButton titleLabel] text] isEqualToString:@"Hide Visits"]) {
        if (ZOOMED_IN) {
            if (!placedCorrectly) {
                [self reloadAnnotations];
            }
            placedCorrectly = YES;
        }
        else {
            if (placedCorrectly) {
                [self removeVisitsFromMap];
                [self showTripsOnMap];
                placedCorrectly = NO;
            }
        }
    }
}

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
    if (ZOOMED_IN) {
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
    else {
        [self showTripsOnMap];
        placedCorrectly = NO;
    }
}

- (void)showTripsOnMap {
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
    else {
        VTTripAnnotation *annotation = [[VTTripAnnotation alloc] initWithTrip:[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex]];
        [annotation setTitle:[[VTTripHandler tripNames] objectAtIndex:_settingsPickerIndex]];
        [annotation setSubtitle:[NSString stringWithFormat:@"%lu visits", (unsigned long)[[[[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex] visitHandler] visits] count]]];
        [annotation setCoordinate:((VTVisit *)[[[[[VTTripHandler trips] objectAtIndex:_settingsPickerIndex] visitHandler] visits] objectAtIndex:0]).place.address.coordinate];
        [_mapView addAnnotation:annotation];
    }
}

- (void)showAllVisitsForTrip:(VTTrip *)trip {
    for (NSUInteger i = 0; i < [[[trip visitHandler] visits] count]; i++) {
        VTVisit *visit = [[[trip visitHandler] visits] objectAtIndex:i];
        NSString *placeName = visit.place.venue.name;
        NSString *uID = visit.place.venue.venueId;
        
        if ([[_annotations allKeys] indexOfObject:uID] == NSNotFound) {
            VTVisitAnnotation *annotation = [[VTVisitAnnotation alloc] initWithVisit:visit];
            // If there is no valid venue name, set it to the address
            if (placeName == nil) {
                LKAddress *address = visit.place.address;
                NSArray *streetName = [address.streetName componentsSeparatedByString:@" "];
                
                NSString *name = address.streetNumber;
                for (int x = 0; x < [streetName count]; x++) {
                    name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] lowercaseString]];
                }
                [annotation setTitle:name];
            }
            else {
                NSNumber *a = [[NSNumber alloc] initWithInt:1];
                [annotation setTitle:placeName];
                [_annotations setObject:annotation forKey:uID];
                [_numbVisits setObject:[a copy] forKey:uID];
            }
            [annotation setSubtitle:@"1 visit"];
            [annotation setCoordinate:visit.place.address.coordinate];
            [_mapView addAnnotation:annotation];
        }
        else {
            NSNumber *b = [[NSNumber alloc] initWithInt:[[_numbVisits objectForKey:uID] intValue] + 1];
            [_numbVisits setObject:[b copy] forKey:uID];
            [[_annotations objectForKey:uID] setTitle:placeName];
            [[_annotations objectForKey:uID] setSubtitle:[NSString stringWithFormat:@"%d visits", [b intValue]]];
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

- (IBAction)searchTapped:(id)sender {
    UIAlertController *searchInput = [UIAlertController alertControllerWithTitle:@"Search" message:@"Search for places around you" preferredStyle:UIAlertControllerStyleAlert];
    [searchInput addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        [textField setAutocorrectionType:UITextAutocorrectionTypeYes];
        [textField setAutocapitalizationType:UITextAutocapitalizationTypeSentences];
    }];
    [[searchInput.view.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *searchAction = [UIAlertAction actionWithTitle:@"Search" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[LocationKit sharedInstance] getCurrentLocationWithHandler:^(CLLocation *location, NSError *error) {
            if (error == nil) {
                NSString *searchText = [[[[searchInput textFields] objectAtIndex:0] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                // Name
                LKSearchRequest *searchRequest = [[LKSearchRequest alloc] initWithLocation:location];
                [searchRequest setQuery:searchText];
                [[LocationKit sharedInstance] searchForPlacesWithRequest:searchRequest completionHandler:^(NSArray *places, NSError *error) {
                    if (error == nil) {
                        NSLog(@"Searching for %@", [[[searchInput textFields] objectAtIndex:0] text]);
                        for (int x = 0; x < [places count]; x++) {
                            NSLog(@"Place %d: %@", x, ((LKPlace *)places[x]).venue.name);
                        }
                    }
                }];
                
                // Category
                searchRequest = [[LKSearchRequest alloc] initWithLocation:location];
                [searchRequest setCategory:searchText];
                [[LocationKit sharedInstance] searchForPlacesWithRequest:searchRequest completionHandler:^(NSArray *places, NSError *error) {
                    NSLog(@"Searching for %@", searchText);
                    for (int x = 0; x < [places count]; x++) {
                        NSLog(@"Place %d: %@", x, ((LKPlace *)places[x]).venue.name);
                    }
                }];
            }
        }];
    }];
    [searchInput addAction:cancelAction];
    [searchInput addAction:searchAction];
    [self presentViewController:searchInput animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowMapSettingsID"]) {
        [[segue destinationViewController] setSelectedRow:[sender settingsPickerIndex] fromSender:self];
    }
    else if ([[segue identifier] isEqualToString:@"MapToVisitsID"]) {
        [[segue destinationViewController] setVisits:[[[[sender annotation] trip] visitHandler] visits]];
        [[segue destinationViewController] setTrip:[[sender annotation] trip]];
    }
    else if ([[segue identifier] isEqualToString:@"MapToVisitDetailID"]) {
        [[segue destinationViewController] setVisit:[[sender annotation] visit]];
    }
}


@end
