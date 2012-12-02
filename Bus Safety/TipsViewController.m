//
//  TipsViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/21/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end


@implementation TipsViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

@synthesize webView;

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = FALSE;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackedViewName = @"Tips";
	// Do any additional setup after loading the view.
    
    self.title = @"Travel Tips";
    
    //NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:@"index.html"]]];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tipsindex" ofType:@"html"] isDirectory:NO]]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tipsindex" ofType:@"html"inDirectory:@"www"]]]];
    
    //NSLog(@"%@", [NSURL fileURLWithPath:@"tipsindex.html"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
