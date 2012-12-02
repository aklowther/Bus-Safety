//
//  BusSeachByLocationViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/21/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "BusSeachByLocationViewController.h"

@interface BusSeachByLocationViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation BusSeachByLocationViewController
@synthesize webView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = FALSE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Bus Search";
    self.trackedViewName = self.title;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://maps.google.com/maps?q=Travel+Bus+Companies&hl=en&sll=27.698638,-83.804601&sspn=10.106521,15.314941&hq=bus+companies&t=m&z=6"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
