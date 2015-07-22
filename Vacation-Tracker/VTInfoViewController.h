//
//  VTInfoViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/21/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property NSUInteger pageIndex;

@property NSString *titleText;

@property NSString *imageFile;

@end
