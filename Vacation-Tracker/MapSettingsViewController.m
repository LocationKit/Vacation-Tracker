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
    // Welcome page
    OnboardingContentViewController *welcomePage = [OnboardingContentViewController contentWithTitle:@"Welcome!" body:@"Thank you for downloading VacationTracker." image:nil buttonText:nil action:nil];
    [welcomePage setTitleTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [welcomePage setUnderTitlePadding:185];
    
    // First info page
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Introduction" body:@"VacationTracker automatically saves the places you visit during your vacations so they can easily be viewed later." image:nil buttonText:nil action:nil];
    [firstPage setUnderTitlePadding:150];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"If you want to see all of your visits, they can be shown on the map. If you want to see info about them, visits are sorted by trip in the list view." image:nil buttonText:nil action:nil];
    [secondPage setUnderTitlePadding:130];
    
    // Second info page
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"You can use the search button to discover places around you." image:nil buttonText:nil action:nil];
    [thirdPage setUnderTitlePadding:185];
    
    // Third info page
    OnboardingContentViewController *fourthPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"You can also create a visit at your current place using the pin button." image:nil buttonText:@"Get Started!" action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
    [fourthPage setButtonTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [fourthPage setUnderTitlePadding:185];
    
    
    // Main onboarding vc
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"info-background"] contents:@[welcomePage, firstPage, secondPage, thirdPage, fourthPage]];
    
    // Configures appearance
    [onboardingVC setTopPadding:10];
    
    [onboardingVC setBottomPadding:10];
    [onboardingVC setShouldFadeTransitions:YES];
    
    // Configures page control
    [onboardingVC.pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [onboardingVC.pageControl setBackgroundColor:[UIColor clearColor]];
    [onboardingVC.pageControl setOpaque:NO];
    // Allows the info to be skipped
    [onboardingVC setAllowSkipping:YES];
    onboardingVC.skipHandler = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    };
    [self presentViewController:onboardingVC animated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)setSelectedRow:(NSUInteger)index fromSender:(UIViewController *)sender {
    indexToSet = index + 1;
    _parent = sender;
}

@end
