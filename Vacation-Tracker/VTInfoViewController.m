//
//  VTInfoViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/21/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTInfoViewController.h"

@interface VTInfoViewController ()

@end

@implementation VTInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
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
