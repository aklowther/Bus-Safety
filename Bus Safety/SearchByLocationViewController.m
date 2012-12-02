//
//  SearchByLocationViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "SearchByLocationViewController.h"

@interface SearchByLocationViewController ()
@end

@implementation SearchByLocationViewController
@synthesize mapView = _mapView;
@synthesize searchForLocation = _searchForLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    CLLocation *location = [manager location];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([location coordinate], 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    self.navigationController.navigationBarHidden = FALSE;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = self.title;
    self.navigationController.navigationBarHidden = FALSE;
    self.title = [NSString stringWithFormat:@"Search Location"];
    self.searchForLocation.text = @"Travel Bus Companies";
    manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    manager.distanceFilter = kCLDistanceFilterNone;
    [manager startUpdatingLocation];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [manager stopUpdatingLocation];
    [super viewDidUnload];
}

@end
