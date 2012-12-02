//
//  BusViewController.m
//  Bus Safety
//
//  Created by Nate Madera on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "BusViewController.h"

@interface BusViewController () <UINavigationControllerDelegate>
@end

@implementation BusViewController
@synthesize ezRiderTopButton;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = @"Home";
    self.navigationController.navigationBarHidden = FALSE;
    self.navigationController.delegate = self;
    self.ezRiderTopButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //(search *)viewController.bool = YES
}

- (void)viewDidUnload {
    [self setEzRiderTopButton:nil];
    [super viewDidUnload];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    destinationView = [segue destinationViewController];
//    destinationView.importedURL = @"http://www.google.com";
//
//}
@end
