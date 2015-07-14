//
//  VTVisitCommentsViewController.h
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/14/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTVisit.h"

@interface VTVisitCommentsViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) VTVisit *visit;

@property (weak, nonatomic) IBOutlet UITextView *commentsEntry;

@end
