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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
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

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    if ([views count] != 1) {
        [searching dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)markNearbyPlaces {
    searching = [UIAlertController alertControllerWithTitle:@"Searching..." message:@"Finding places around you.\nThis may take a few seconds." preferredStyle:UIAlertControllerStyleAlert];
    // Gets the user's current location to use for the SearchRequest location.
    [[LocationKit sharedInstance] getCurrentLocationWithHandler:^(CLLocation *location, NSError *error) {
        if (error == nil) {
            [_mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)];
            [self presentViewController:searching animated:NO completion:nil];
            LKSearchRequest *searchRequest = [[LKSearchRequest alloc] initWithLocation:location];
            [[LocationKit sharedInstance] searchForPlacesWithRequest:searchRequest completionHandler:^(NSArray *places, NSError *error) {
                if (error == nil) {
                    [self markPlaces:places];
                }
                else {
                    NSLog(@"%@", error);
                    [searching dismissViewControllerAnimated:NO completion:nil];
                    [self showErrorWithMessage:@"Could not find places"];
                    return;
                }
            }];
        }
        else {
            if (_mapView.userLocation != nil) {
                location = (CLLocation *)_mapView.userLocation;
                [_mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)];
                [self presentViewController:searching animated:NO completion:nil];
                LKSearchRequest *searchRequest = [[LKSearchRequest alloc] initWithLocation:location];
                [[LocationKit sharedInstance] searchForPlacesWithRequest:searchRequest completionHandler:^(NSArray *places, NSError *error) {
                    if (error == nil) {
                        [self markPlaces:places];
                    }
                    else {
                        NSLog(@"%@", error);
                        [searching dismissViewControllerAnimated:NO completion:nil];
                        [self showErrorWithMessage:@"Could not find places"];
                        return;
                    }
                }];
            }
            else {
                NSLog(@"%@", error);
                [searching dismissViewControllerAnimated:NO completion:nil];
                [self showErrorWithMessage:@"Could not find your current location"];
                return;
            }
        }
    }];
}

- (void)showErrorWithMessage:(NSString *)message {
    UIAlertController *error = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
    [error.view setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [error addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [error dismissViewControllerAnimated:NO completion:nil];
    }]];
    [searching dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:error animated:YES completion:nil];

}

- (void)markPlaces:(NSArray *)places {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    for (int x = 0; x < [places count]; x++) {
        LKPlace *currentPlace = [places objectAtIndex:x];
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:currentPlace.address.coordinate];
        [annotation setTitle:currentPlace.venue.name];
        [annotations addObject:annotation];
    }
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
