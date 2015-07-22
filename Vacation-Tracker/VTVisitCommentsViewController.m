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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_commentsEntry becomeFirstResponder];
}

- (IBAction)didTapCancel:(id)sender {
    [_commentsEntry resignFirstResponder];
    UIAlertController *confirm = [UIAlertController alertControllerWithTitle:@"Discard Changes?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [confirm dismissViewControllerAnimated:YES completion:nil];
        [_commentsEntry becomeFirstResponder];
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

@end
