//
//  MapSettingsViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/1/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapSettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

- (void)setSelectedRow:(NSUInteger)index fromSender:(UIViewController *)sender;

@end
