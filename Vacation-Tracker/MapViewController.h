//
//  MapViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *debugSwitch; // debug only

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *visitsButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *displayPrefs;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property NSInteger settingsPickerIndex;

- (void)reloadAnnotations;

+ (BOOL)debugSwitchState; // debug only

@end
