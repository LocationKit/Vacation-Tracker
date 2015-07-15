//
//  VisitDetailViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocationKit/LocationKit.h>
#import <MapKit/MapKit.h>
#import "VTVisit.h"
#import "VTVisitCommentsViewController.h"

@interface VisitDetailViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) VTVisit *visit;   // The visit about which details are being displayed.

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *address_0;

@property (weak, nonatomic) IBOutlet UILabel *address_1;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *localityLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (weak, nonatomic) IBOutlet UIStepper *ratingStepper;

@end
