//
//  VTListViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTListViewController.h"
#import "VTVisitHandler.h"
#import "VisitViewCell.h"

@interface VTListViewController ()

@property (strong, nonatomic) NSMutableArray *visits;

@end

@implementation VTListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _visits = [VTVisitHandler visits];
    [_tableView reloadData];
    
    [VTVisitHandler registerObserver:^(NSNotification *note) {
        if(note.name != VTVisitsChangedNotification) {
            return;
        }
        _visits = note.object;
        [_tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_visits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TableCellID";
    
    VisitViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [_tableView registerNib:[UINib nibWithNibName:@"VisitViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
        [cell setVisit:[self getVisitForIndex:indexPath.row]];
    }
    return cell;
}

- (LKVisit *)getVisitForIndex:(NSUInteger)index {
    return [_visits objectAtIndex:index];
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
