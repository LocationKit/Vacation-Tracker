//
//  MapSettingsViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/1/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "MapSettingsViewController.h"
#import "VTTripHandler.h"
#import "MapViewController.h"
#import "TabBarViewController.h"
#import <Onboard/OnboardingContentViewController.h>
#import <Onboard/OnboardingViewController.h>

@interface MapSettingsViewController ()

@property (strong, nonatomic) UIViewController *parent;

@end

@implementation MapSettingsViewController
NSUInteger indexToSet;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_timePicker selectRow:indexToSet inComponent:0 animated:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[VTTripHandler trips] count] + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // The first item should be an "All" option
    if (row == 0) {
        return @"All Trips";
    }
    else {
        return [[VTTripHandler tripNames] objectAtIndex:row - 1];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (IBAction)didTapDone:(id)sender {
    [(MapViewController *)_parent setSettingsPickerIndex:[_timePicker selectedRowInComponent:0] - 1];
    [(MapViewController *)_parent reloadAnnotations];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapPrivacySettings:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (IBAction)didTapRewatch:(id)sender {
    [TabBarViewController showWelcomeFromViewController:self];
}

- (void)setSelectedRow:(NSUInteger)index fromSender:(UIViewController *)sender {
    indexToSet = index + 1;
    _parent = sender;
}

@end
