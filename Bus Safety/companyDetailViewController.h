//
//  companyDetailViewController.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/16/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface companyDetailViewController : GAITrackedViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) UIImage *driverImage;
@property (nonatomic, retain) UIView *activityView;
@property (nonatomic, weak) NSString *driversFatigue;
@property (nonatomic, weak) NSString *driversFitness;
@property (nonatomic, weak) NSString *driversSubstance;
@property (nonatomic, strong) NSString *vehiclesMaint;
@property (nonatomic, strong) NSString *vehiclesUnsafe;
@property (nonatomic, strong) NSString *allowedToOperate;

- (IBAction)infoButtonPressed:(id)sender;
- (IBAction)percentInfoButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
