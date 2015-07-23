//
//  TabBarViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "TabBarViewController.h"
#import <Onboard/OnboardingContentViewController.h>
#import <Onboard/OnboardingViewController.h>

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView {
    [super loadView];
    [[self tabBar] setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];  // Sets tab bar tint color to SocialRadar's orange
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Shows an information onboard the first time the app is launched.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [TabBarViewController showWelcomeFromViewController:self];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// Shows the welcome page from a viewcontroller
+ (void)showWelcomeFromViewController:(UIViewController *)sender {
    // Welcome page
    OnboardingContentViewController *welcomePage = [OnboardingContentViewController contentWithTitle:@"Welcome!" body:@"Thank you for downloading VacationTracker." image:nil buttonText:nil action:nil];
    [welcomePage setTitleTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [welcomePage setUnderTitlePadding:185];
    
    // First info page
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Introduction" body:@"VacationTracker automatically saves the places you visit during your vacations so they can easily be viewed later." image:nil buttonText:nil action:nil];
    [firstPage setUnderTitlePadding:150];
    
    // Second info page
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Features" body:@"Visits can be shown on the map or viewed in the list view. When viewing a visit, you can add a rating and comments." image:nil buttonText:nil action:nil];
    [secondPage setUnderTitlePadding:150];
    
    // Third info page
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Controls" body:@"You can use the search button to discover places around you, and the pin button creates a visit at your current location." image:nil buttonText:@"Get Started!" action:^{
        [sender dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
    [thirdPage setUnderTitlePadding:150];
    [thirdPage setButtonTextColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];    
    
    // Main onboarding vc
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"info-background"] contents:@[welcomePage, firstPage, secondPage, thirdPage]];
    
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
        [sender dismissViewControllerAnimated:YES completion:nil];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    };
    [sender presentViewController:onboardingVC animated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
