//
//  VTTripListViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/25/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTTripListViewController.h"
#import "TripViewCell.h"

@interface VTTripListViewController ()

@property (strong, nonatomic) NSMutableArray *trips;
@property (strong, nonatomic) NSIndexPath *selected;

@end

@implementation VTTripListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView reloadData];
    
    // Reloads data when trips are changed
    [VTTripHandler registerTripObserver:^(NSNotification *note) {
        if(note.name != VTTripsChangedNotification) {
            return;
        }
        [_tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[VTTripHandler trips] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"TripCellID";
        
    TripViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [_tableView registerNib:[UINib nibWithNibName:@"TripViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    }
    [cell setTrip:[[VTTripHandler trips] objectAtIndex:[[VTTripHandler trips] count] - 1 - indexPath.row]];
    return cell;
}

- (VTTrip *)getTripForTableIndex:(NSUInteger)index {
    NSUInteger maxIndex = [[VTTripHandler trips] count] - 1;
    return [[VTTripHandler trips] objectAtIndex:maxIndex - index];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selected = indexPath;
    [self performSegueWithIdentifier:@"ShowTripVisitsID" sender:tableView];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowTripVisitsID"]) {
        [_tableView deselectRowAtIndexPath:[sender indexPathForSelectedRow] animated:YES];
        [[segue destinationViewController] setTrip:[self getTripForTableIndex:_selected.row]];
    }
}

@end
