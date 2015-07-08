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
    
    // Creates an array from the street name components separated by a space.
    NSArray *streetName = [_visit.place.address.streetName componentsSeparatedByString:@" "];
    
    NSString *name = _visit.place.address.streetNumber;
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
    
    if (_visit.place.venue.name == nil) {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", name]];
    }
    else {
        [self.navigationItem setTitle:[NSString stringWithFormat:@"Visit to %@", _visit.place.venue.name]];   // Sets navigation bar title to 'Visit to <place name>'
    }
    
    [_address_0 setText:name];
    [_address_1 setText:[NSString stringWithFormat:@"%@, %@ %@", [_visit.place.address.locality capitalizedString], _visit.place.address.region, _visit.place.address.postalCode]];
    
    [_categoryLabel setText:_visit.place.venue.category];
    
    [_localityLabel setText:_visit.place.address.locality];
    // Do any additional setup after loading the view.
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
