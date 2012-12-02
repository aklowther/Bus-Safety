//
//  AboutViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/21/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize aboutTextView, aboutWebView, importedURL;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = self.title;
    if (self.importedURL.length == 0) {
        self.importedURL = @"http://www.l0wth3r.com/aboutPage.html";
    }
    [self.aboutWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.importedURL]]];
    //[self.aboutWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"aboutindex" ofType:@"html"inDirectory:@"www"]]]];
    //self.aboutTextView.editable = NO;
    //self.aboutTextView.text = [NSString stringWithFormat:@"<b>About FMCSA<\b>\n\nThe Federal Motor Carrier Safety Administration (FMCSA) was established within the Department of Transportation on January 1, 2000, pursuant to the Motor Carrier Safety Improvement Act of 1999 (49 U.S.C. 113). Formerly a part of the Federal Highway Administration, the Federal Motor Carrier Safety Administration's primary mission is to prevent commercial motor vehicle-related fatalities and injuries. Activities of the Administration contribute to ensuring safety in motor carrier operations through strong enforcement of safety regulations; targeting high-risk carriers and commercial motor vehicle drivers; improving safety information systems and commercial motor vehicle technologies; strengthening commercial motor vehicle equipment and operating standards; and increasing safety awareness. To accomplish these activities, the Administration works with Federal, State, and local enforcement agencies, the motor carrier industry, labor safety interest groups, and others.\n\n"];
    //self.aboutTextView.text;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAboutWebView:nil];
    [super viewDidUnload];
}
@end
