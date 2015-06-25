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

@end

@implementation VTTripListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView reloadData];
    
    // Resets trips and reloads data when trips are changed
    [VTTripHandler registerTripObserver:^(NSNotification *note) {
        if(note.name != VTTripsChangedNotification) {
            return;
        }
        _trips = note.object;
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
    [cell setTrip:[self getTripForIndex:indexPath.row]];
    return cell;
}

- (VTTrip *)getTripForIndex:(NSUInteger)index {
    return [[VTTripHandler trips] objectAtIndex:index];
}

- (NSMutableArray *)getVisitsForTripIndex:(NSUInteger)index {
    return [[[[VTTripHandler trips] objectAtIndex:index] visitHandler] visits];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ShowTripVisitsID" sender:tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowTripVisitsID"]) {
        NSMutableArray *visits = [self getVisitsForTripIndex:[sender indexPathForSelectedRow].row];
        [_tableView deselectRowAtIndexPath:[sender indexPathForSelectedRow] animated:YES];
        [[segue destinationViewController] setVisits:visits];
        [[segue destinationViewController] setTripName:[[self getTripForIndex:[sender indexPathForSelectedRow].row] tripName]];
    }
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
