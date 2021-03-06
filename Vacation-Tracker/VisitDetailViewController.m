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
NSString *name;

@implementation VisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [_ratingStepper setValue:[_visit rating]];
    
    placeName = [_visit place].venue.name;
    
    LKAddress *address = _visit.place.address;
    NSArray *streetName = [address.streetName componentsSeparatedByString:@" "];
    
    name = address.streetNumber;
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
    [self addAnnotation];
    if (placeName == nil) {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", name]];
    }
    else {
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
    
    [_address_0 setText:name];
    [_address_1 setText:[NSString stringWithFormat:@"%@, %@ %@", [address.locality capitalizedString], address.region, address.postalCode]];
    
    if (_visit.place.venue.category != nil) {
        [_categoryLabel setText:_visit.place.venue.category];
    }
    
    else {
        [_categoryLabel setText:@"None"];
    }
    
    [_localityLabel setText:_visit.place.address.locality];
    // Do any additional setup after loading the view.
}

// Updates the rating when the rating stepper is changed.
- (IBAction)stepperChanged:(id)sender {
    [_visit setRating:[_ratingStepper value]];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [VTTripHandler notifyTripChange:[VTTripHandler trips]];
}

// Adds the visit to the small map.
- (void)addAnnotation {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    if (placeName == nil) {
        [annotation setTitle:[NSString stringWithFormat:@"Visit to %@", name]];
    }
    else {
        [annotation setTitle:placeName];
    }
    [annotation setCoordinate:_visit.place.address.coordinate];
    [_mapView setCenterCoordinate:annotation.coordinate];
    [_mapView setMapType:MKMapTypeHybrid];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance([_mapView centerCoordinate], 0.1f / MILE_TO_METER, 0.1f / MILE_TO_METER)];
    [_mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapCommnentsButton:(id)sender {
    [self performSegueWithIdentifier:@"DetailsToCommentsSegueID" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailsToCommentsSegueID"]) {
        [[[[segue destinationViewController] viewControllers] objectAtIndex:0] setVisit:_visit];
    }
}


@end
