//
//  VTMapVisitDetailViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/8/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTVisit.h"

@interface VTMapVisitDetailViewController : UIViewController

@property (strong, nonatomic) VTVisit *visit;

@property (weak, nonatomic) IBOutlet UILabel *address_0;

@property (weak, nonatomic) IBOutlet UILabel *address_1;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *localityLabel;

@end
