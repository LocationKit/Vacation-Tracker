//
//  VTInfoBaseViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/21/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTInfoBaseViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageTitles;

@property (strong, nonatomic) NSArray *pageImages;

@end
