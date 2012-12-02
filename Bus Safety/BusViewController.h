//
//  BusViewController.h
//  Bus Safety
//
//  Created by Nate Madera on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface BusViewController : GAITrackedViewController
@property (weak, nonatomic) IBOutlet UIButton *ezRiderTopButton;
- (IBAction)infoButtonPressed:(id)sender;

@end
