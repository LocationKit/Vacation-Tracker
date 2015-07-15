//
//  VTFindViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/9/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTFindViewController.h"
#import <LocationKit/LocationKit.h>

@interface VTFindViewController ()

@end

@implementation VTFindViewController

UIAlertController *searching;

static NSArray *lastFoundPlaces;
static CLLocation *lastLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self removeAnnotations];
    [self markNearbyPlaces];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    else {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"NearbyAnnotationID"];
        if (annotationView) {
            [annotationView setAnnotation:annotation];
        }
        else {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"NearbyAnnotationID"];
        }
        [annotationView setPinColor:MKPinAnnotationColorPurple];
        [annotationView setCanShowCallout:YES];
        return annotationView;
    }
    return nil;
}

// When all the locations are done being added, the 'searching' alert is dismissed.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    // Should not happen when the userLocation dot is added.
    if (![[[views objectAtIndex:0] annotation] isKindOfClass:[MKUserLocation class]]) {
        [searching dismissViewControllerAnimated:YES completion:nil];
        if (lastLocation != nil) {
            [_mapView setRegion:MKCoordinateRegionMakeWithDistance(lastLocation.coordinate, 1000, 1000) animated:YES];
        }
    }
    
}

// Removes all annotations from the map (except for the userLocation dot).
- (void)removeAnnotations {
    id userLocation = [_mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[_mapView annotations]];
    
    if (userLocation != nil) {
        [pins removeObject:userLocation];
    }
    [_mapView removeAnnotations:pins];
}

- (void)markNearbyPlaces {
    searching = [UIAlertController alertControllerWithTitle:@"Searching..." message:@"Finding places around you. This may take a few seconds." preferredStyle:UIAlertControllerStyleAlert]; // Displayed while the annotations are being added so it doesn't appear as though the app is hanging.
    
    // Gets the user's current location to use for the SearchRequest location.
    [[LocationKit sharedInstance] getCurrentLocationWithHandler:^(CLLocation *location, NSError *error) {
        // If there is no problem obtaining the location, continue.
        if (error == nil && location != nil) {
            // If the user is close to the last search location, there is no need to re-search.  The old search is simply displayed.
            if (lastLocation != nil && [location distanceFromLocation:lastLocation] <= 30) {
                [self presentViewController:searching animated:NO completion:nil];
                [_mapView addAnnotations:lastFoundPlaces];
            }
            // Otherwise a search is actually performed.
            else {
                lastLocation = location;
                
                // SearchRequest with current location is created and sent.
                LKSearchRequest *searchRequest = [[LKSearchRequest alloc] initWithLocation:location];
                [[LocationKit sharedInstance] searchForPlacesWithRequest:searchRequest completionHandler:^(NSArray *places, NSError *error) {
                    // If no places are nearby, tell the user.
                    if (places == nil || [places count] == 0) {
                        [self showErrorWithMessage:@"No places found."];
                    }
                    // If there was no issue, mark the places on the map.
                    else if (error == nil) {
                        [self presentViewController:searching animated:NO completion:nil];
                        [self markPlaces:places];
                    }
                    // If there was an error, log and report it to the user.
                    else {
                        NSLog(@"Place search error: %@", error);
                        [self showErrorWithMessage:@"Could not find places."];
                    }
                }];
            }
        }
        // If there is an error, log and report it to the user.
        else {
            NSLog(@"Location error: %@", error);
            [self showErrorWithMessage:@"Could not find places."];
        }
    }];
}

// Shows an error message to the user.
- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    [error.view setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [error addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [error dismissViewControllerAnimated:NO completion:nil];
        [[self navigationController] popViewControllerAnimated:YES];
    }]];
    [searching dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:error animated:YES completion:nil];

}

- (void)markPlaces:(NSArray *)places {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    // Loops through all places and creates and adds an annotation for each one.
    for (int x = 0; x < [places count]; x++) {
        LKPlace *currentPlace = [places objectAtIndex:x];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:currentPlace.address.coordinate];
        [annotation setTitle:currentPlace.venue.name];
        [annotations addObject:annotation];
    }
    lastFoundPlaces = annotations;
    // Annotations are added in bulk.
    [_mapView addAnnotations:annotations];
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
