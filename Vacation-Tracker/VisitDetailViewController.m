//
//  VisitDetailViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VisitDetailViewController.h"
#import "VTTripHandler.h"

#define MILE_TO_METER 0.00062137f

@interface VisitDetailViewController ()

@end

NSString *placeName;

@implementation VisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [_ratingStepper setValue:[_visit rating]];
    
    placeName = [_visit place].venue.name;
    
    [self addAnnotation];
    
    if (placeName == nil) {
        [_locationLabel setText:@"Unregistered Place"];
        [self.navigationItem setTitle:@"Unregistered Place"];
    }
    else {
        [_locationLabel setText:placeName];
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", placeName]];   // Sets navigation bar title to 'Visit to <place name>'
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [dateFormatter stringFromDate:[_visit arrivalDate]];
    [_dateLabel setText:dateString];
    
    dateFormatter.dateFormat = @"h:mm a";
    dateString = [dateFormatter stringFromDate: [_visit arrivalDate]];
    [_timeLabel setText:dateString];
    
    LKAddress *address = _visit.place.address;
    NSArray *streetName = [address.streetName componentsSeparatedByString:@" "];
    
    NSString *name = address.streetNumber;
    for (int x = 0; x < [streetName count]; x++) {
        /*NSString *current = [streetName objectAtIndex:x];
        if ([current intValue] == 0) {
            name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] capitalizedString]];
        }
        else {*/
            name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] lowercaseString]];
        //}
    }
    [_address_0 setText:name];
    /*
    if ([streetName count] == 3) {
        [_address_0 setText:[NSString stringWithFormat:@"%@ %@ %@ %@", address.streetNumber, [streetName[0] lowercaseString], [streetName[1] capitalizedString], streetName[2]]];
    }
    else {
        [_address_0 setText:[NSString stringWithFormat:@"%@ %@ %@", address.streetNumber, [streetName[0] lowercaseString], [streetName[1] capitalizedString]]];
    }
     */
    [_address_1 setText:[NSString stringWithFormat:@"%@, %@", [address.locality capitalizedString], address.region]];
    
    [_categoryLabel setText:_visit.place.venue.category];
    
    [_localityLabel setText:_visit.place.address.locality];
    // Do any additional setup after loading the view.
}

- (IBAction)stepperChanged:(id)sender {
    [_visit setRating:[_ratingStepper value]];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [VTTripHandler notifyTripChange:[VTTripHandler trips]];
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
