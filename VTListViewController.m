//
//  VTListViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTListViewController.h"
#import "VTTripHandler.h"
#import "VisitViewCell.h"

@interface VTListViewController ()

@end

@implementation VTListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Visits in %@", [[_trip tripName] capitalizedStringWithLocale:[NSLocale currentLocale]]]];   // Sets navigation bar title to 'Visits in <locale>'
    
    _visits = [[[_trip visitHandler] visits] copy];
    [_tableView reloadData];
    
    [VTTripHandler registerVisitObserver:^(NSNotification *note) {
        if(note.name != VTVisitsChangedNotification) {
            return;
        }
        if ([[note.object objectAtIndex:0] isEqualToString:[_trip tripName]]) {
            NSUInteger oldCount = [_visits count];
            _visits = [[note.object objectAtIndex:1] copy];
            if (!([[note.object objectAtIndex:1] count] < oldCount)) {
                [_tableView reloadData];
            }
        }
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
    static NSString *cellID = @"VisitCellID";
        
    VisitViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [_tableView registerNib:[UINib nibWithNibName:@"VisitViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    }
    [cell setVisit:[self getVisitForIndex:indexPath.row]];
    NSString *category = [self getVisitForIndex:indexPath.row].place.venue.category;
    if (!category) {
        [[cell imageView] setImage:[UIImage imageNamed:@"map-button-item"]];
    }
    else {
        if ([category isEqualToString:@"Bars"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-bars"]];
        }
        else if ([category isEqualToString:@"Fitness Sports and Recreation"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-fitness"]];
        }
        else if ([category isEqualToString:@"Grocery"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-grocery"]];
        }
        else if ([category isEqualToString:@"Home and Garden"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-home-garden"]];
        }
        else if ([category isEqualToString:@"Personal Care and Services"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-personal-care"]];
        }
        else if ([category isEqualToString:@"Restaurants"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-restaurant"]];
        }
        else if ([category isEqualToString:@"Retail"]) {
            [[cell imageView] setImage:[UIImage imageNamed:@"category-retail"]];
        }
        else {
            [[cell imageView] setImage:[UIImage imageNamed:@"map-button-item"]];
        }
    }
    return cell;
}

// Displays an alert view confirming the decision to clear all visits.
- (IBAction)clearVisits:(id)sender {
    UIAlertController *confirmation = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:@"This will clear all visits." preferredStyle:UIAlertControllerStyleAlert];
    [confirmation.view setTintColor:[UIColor colorWithRed:.97 green:.33 blue:.1 alpha:1]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        _visits = [[NSMutableArray alloc] init];
        [[_trip visitHandler] setVisits:[[NSMutableArray alloc] init]];
        [[VTTripHandler tripNames] removeObject:[_trip tripName]];
        [[VTTripHandler trips] removeObject:_trip];
        [VTTripHandler notifyVisitChange:[[NSArray alloc] initWithObjects:[_trip tripName], [_visits copy], nil]];
        [[self navigationController] popViewControllerAnimated:YES];
    }];
    [confirmation addAction:cancelAction];
    [confirmation addAction:continueAction];
    [self presentViewController:confirmation animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"VisitDetailSegueID" sender:tableView];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *trips = [VTTripHandler trips];
        NSMutableArray *tripNames = [VTTripHandler tripNames];
        
        VTVisitHandler *visitHandler = [[trips objectAtIndex:[tripNames indexOfObject:[_trip tripName]]] visitHandler];
        [visitHandler removeVisitAtIndex:indexPath.row];
        _visits = [[visitHandler visits] copy];
        [_tableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
        
        if ([_visits count] == 0) {
            _visits = [[NSMutableArray alloc] init];
            [[_trip visitHandler] setVisits:[[NSMutableArray alloc] init]];
            [[VTTripHandler tripNames] removeObject:[_trip tripName]];
            [[VTTripHandler trips] removeObject:_trip];
            [VTTripHandler notifyVisitChange:[[NSArray alloc] initWithObjects:[_trip tripName], [_visits copy], nil]];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

- (VTVisit *)getVisitForIndex:(NSUInteger)index {
    NSUInteger lastIndex = [_visits count] - 1;
    return [_visits objectAtIndex:lastIndex - index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VisitDetailSegueID"]) {
        VTVisit *visit = [self getVisitForIndex:[sender indexPathForSelectedRow].row];
        [_tableView deselectRowAtIndexPath:[sender indexPathForSelectedRow] animated:YES];
        [[segue destinationViewController] setVisit:visit];
    }
}

@end
