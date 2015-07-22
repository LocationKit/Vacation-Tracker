//
//  TabBarViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "TabBarViewController.h"
#import "VTInfoViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    //{
        [self performSegueWithIdentifier:@"ShowInfoSegueID" sender:self];
    //    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    //}
}

- (void)loadView {
    [super loadView];
    [[self tabBar] setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];  // Sets tab bar tint color to SocialRadar's orange
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
