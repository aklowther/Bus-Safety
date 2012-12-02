//
//  AboutViewController.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/21/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface AboutViewController : GAITrackedViewController
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UIWebView *aboutWebView;
@property (strong, nonatomic) NSString *importedURL;

@end
