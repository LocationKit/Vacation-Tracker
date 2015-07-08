//
//  VTMapVisitDetailViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/8/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTMapVisitDetailViewController.h"
#import "VTTripHandler.h"

@interface VTMapVisitDetailViewController ()

@end

@implementation VTMapVisitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [_ratingStepper setValue:[_visit rating]];
    
    NSArray *streetName = [_visit.place.address.streetName componentsSeparatedByString:@" "];
    
    NSString *name = _visit.place.address.streetNumber;
    for (int x = 0; x < [streetName count]; x++) {
        name = [name stringByAppendingFormat:@" %@", [[streetName objectAtIndex:x] lowercaseString]];
    }
    
    if (_visit.place.venue.name == nil) {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", name]];
    }
    else {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", _visit.place.venue.name]];   // Sets navigation bar title to 'Visit to <place name>'
    }
    
    [_address_0 setText:name];
    [_address_1 setText:[NSString stringWithFormat:@"%@, %@", [_visit.place.address.locality capitalizedString], _visit.place.address.region]];
    
    [_categoryLabel setText:_visit.place.venue.category];
    
    [_localityLabel setText:_visit.place.address.locality];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stepperChanged:(id)sender {
    [_visit setRating:[_ratingStepper value]];
    [_ratingLabel setText:[NSString stringWithFormat:@"Rating: %.f", [_visit rating]]];
    [VTTripHandler notifyTripChange:[VTTripHandler trips]];
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
