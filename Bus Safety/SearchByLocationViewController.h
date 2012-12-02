//
//  SearchByLocationViewController.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GAI.h"

#define METERS_PER_MILE 1609.344

@interface SearchByLocationViewController : GAITrackedViewController <CLLocationManagerDelegate> {
    BOOL _doneInitialZoom;
    CLLocationManager *manager;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property IBOutlet UISearchBar *searchForLocation;
@end