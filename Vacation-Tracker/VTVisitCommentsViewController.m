//
//  VTVisitCommentsViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 7/14/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTVisitCommentsViewController.h"

@interface VTVisitCommentsViewController ()

@end

@implementation VTVisitCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_commentsEntry setText:[_visit comments]];
    [_commentsEntry showsVerticalScrollIndicator];
    [_commentsEntry setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapCancel:(id)sender {
    [_commentsEntry resignFirstResponder];
    UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"Discard Changes?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [confirm dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *discard = [UIAlertAction actionWithTitle:@"Discard" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [confirm dismissViewControllerAnimated:YES completion:nil];
        [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    }];
    [confirm addAction:cancel];
    [confirm addAction:discard];
    [confirm.view setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    [self presentViewController:confirm animated:YES completion:nil];
}

- (IBAction)didTapDone:(id)sender {
    [_commentsEntry resignFirstResponder];
    [_visit setComments:[_commentsEntry text]];
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
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