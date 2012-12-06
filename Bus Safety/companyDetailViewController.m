//
//  companyDetailViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/16/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import "companyDetailViewController.h"
#import "UIImage+Resize.h"

@interface companyDetailViewController ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *subviewForImage;
@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic) NSInteger uValue;
@property (nonatomic) NSInteger mValue;
@property (nonatomic) NSInteger tValue;
@property (nonatomic) NSInteger fValue;
@property (nonatomic) NSInteger dValue;



- (void)centerScrollViewContents;
@end

@implementation companyDetailViewController

@synthesize infoButton, infoView, containerView, scrollView, subviewForImage, driverImage, allowedToOperate;
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
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = 1.0f;
    
    [self centerScrollViewContents];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.trackedViewName = self.title;
    self.infoView.hidden = YES;

    CGSize containerSize = CGSizeMake(320.0f, 700.0f);
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];

    UIImageView *skyView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 700.0f)];
    skyView.image = [UIImage imageNamed:@"sky.png"];
    [self.containerView addSubview:skyView];
    UIImageView *busImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 250.0f, 320.0f, 171.0f)];
    
    float fit = [self convertAPIResults:self.driversFitness];
    float subs = [self convertAPIResults:self.driversSubstance];
    float fat = [self convertAPIResults:self.driversFatigue];
    float maint = [self convertAPIResults:self.vehiclesMaint];
    float safe = [self convertAPIResults:self.vehiclesUnsafe];
    
    self.uValue = [self convertToImageValue:safe];
    self.mValue = [self convertToImageValue:maint];
    self.tValue = [self convertToImageValue:fat];
    self.fValue = [self convertToImageValue:fit];
    self.dValue = [self convertToImageValue:subs];
    
    self.uValue = [self checkForZero:self.uValue];
    self.dValue = [self checkForZero:self.dValue];
    
    busImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"u%im%i.png",self.uValue, self.dValue]];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 0.0f, 300.0f, 278.0f)];
    if ([self.allowedToOperate characterAtIndex:0] == 78) {
        NSLog(@"Allowed to opperate = NO");
        self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"t%if%id%i.png",4,4,4]];
    }else{
        self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"t%if%id%i.png",self.tValue, self.fValue, self.dValue]];
        if ((self.tValue == 0 && self.fValue == 0) || (self.tValue == 0 && self.dValue == 0) || (self.fValue == 0 && self.dValue == 0) ){
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"t%if%id%i.png",0,0,0]];
        }else{
            self.tValue = [self checkForZero:self.tValue];
            self.fValue = [self checkForZero:self.fValue];
            self.dValue = [self checkForZero:self.dValue];
            self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"t%if%id%i.png",self.tValue, self.fValue, self.dValue]];
        }
    }
    
    
    UIButton *safetyButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    safetyButton.frame = CGRectMake(-25.0f, 443.0f, 70.0f, 50.0f);
    [safetyButton addTarget:self action:@selector(percentInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    safetyButton.tag = 1;
    [self.containerView addSubview:safetyButton];
    UIButton *maintButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    maintButton.frame = CGRectMake(-25.0f, 488.0f, 70.0f, 50.0f);
    [maintButton addTarget:self action:@selector(percentInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    maintButton.tag = 2;
    [self.containerView addSubview:maintButton];
    UIButton *fitnessButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    fitnessButton.frame = CGRectMake(-25.0f, 533.0f, 70.0f, 50.0f);
    [fitnessButton addTarget:self action:@selector(percentInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    fitnessButton.tag = 3;
    [self.containerView addSubview:fitnessButton];
    UIButton *fatigueButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    fatigueButton.frame = CGRectMake(-25.0f, 578.0f, 70.0f, 50.0f);
    [fatigueButton addTarget:self action:@selector(percentInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    fatigueButton.tag = 4;
    [self.containerView addSubview:fatigueButton];
    UIButton *substanceButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    substanceButton.frame = CGRectMake(-25.0f, 623.0f, 70.0f, 50.0f);
    [substanceButton addTarget:self action:@selector(percentInfoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    substanceButton.tag = 5;
    [self.containerView addSubview:substanceButton];
    
    [self performSelector:@selector(addHintView)];
    
    UILabel *safetyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 455.0f, 320.0f, 25.0f)];
    safetyLabel.text = [NSString stringWithFormat:@"Safety Record: %@", self.vehiclesUnsafe];
    safetyLabel.backgroundColor = [UIColor clearColor];
    UIProgressView *safety = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 480.0f, 280.0f, 10.0f)];
    safety.progressViewStyle = UIProgressViewStyleDefault;
    [safety setProgress:(safe/100) animated:YES];
    
    UILabel *maintLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 500.0f, 320.0f, 25.0f)];
    maintLabel.text = [NSString stringWithFormat:@"Maintenance Record: %@", self.vehiclesMaint];
    maintLabel.backgroundColor = [UIColor clearColor];
    UIProgressView *maintView = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 525.0f, 280.0f, 10.0f)];
    maintView.progressViewStyle = UIProgressViewStyleDefault;
    [maintView setProgress:(maint/100) animated:YES];

    UILabel *fitnessLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 545.0f, 320.0f, 25.0f)];
    fitnessLabel.text = [NSString stringWithFormat:@"Fitness Record: %@", self.driversFitness];
    fitnessLabel.backgroundColor = [UIColor clearColor];
    UIProgressView *fitnessView = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 570.0f, 280.0f, 10.0f)];
    fitnessView.progressViewStyle = UIProgressViewStyleDefault;
    [fitnessView setProgress:(fit/100)];
    
    UILabel *fatigueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 590.0f, 320.0f, 25.0f)];
    fatigueLabel.text = [NSString stringWithFormat:@"Fatigue Record: %@", self.driversFatigue];
    fatigueLabel.backgroundColor = [UIColor clearColor];
    UIProgressView *fatigueView = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 615.0f, 280.0f, 10.0f)];
    fatigueView.progressViewStyle = UIProgressViewStyleDefault;
    [fatigueView setProgress:(fat/100)];
    
    UILabel *substanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 635.0f, 320.0f, 25.0f)];
    substanceLabel.text = [NSString stringWithFormat:@"Drug/Alcohol Record: %@", self.driversSubstance];
    substanceLabel.backgroundColor = [UIColor clearColor];
    UIProgressView *substanceView = [[UIProgressView alloc] initWithFrame:CGRectMake(20.0f, 660.0f, 280.0f, 10.0f)];
    substanceView.progressViewStyle = UIProgressViewStyleDefault;
    [substanceView setProgress:(subs/100)];
    
    [self.containerView addSubview:safety];
    [self.containerView addSubview:safetyLabel];
    [self.containerView addSubview:maintLabel];
    [self.containerView addSubview:maintView];
    [self.containerView addSubview:fitnessLabel];
    [self.containerView addSubview:fitnessView];
    [self.containerView addSubview:fatigueLabel];
    [self.containerView addSubview:fatigueView];
    [self.containerView addSubview:substanceLabel];
    [self.containerView addSubview:substanceView];
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:busImage];
    self.scrollView.contentSize = containerSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInfoView:nil];
    [self setInfoButton:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

-(void)checkInfoDisplay{
    if (self.infoView.hidden == YES) {
        self.infoView.hidden = NO;
    }else{
        self.infoView.hidden = YES;
    }
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    self.containerView.frame = contentsFrame;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

- (IBAction)infoButtonPressed:(id)sender {
    //[self checkInfoDisplay];
}

-(float)convertAPIResults:(NSString *) stringFromObj{
    if ([stringFromObj hash] == [@"No Results" hash])
    {
        NSLog(@"stringFromObject:%@",stringFromObj);
        return -101.0f;
    }else if ([stringFromObj hash] == [@"No Violations" hash]){
        NSLog(@"stringFromObject:%@",stringFromObj);
        return -1.0f;
    }
    else{
    NSString *substring = [stringFromObj substringToIndex:([stringFromObj length]-1)];
    NSInteger substringToInt = [substring integerValue];
//    NSLog(@"%@", substring);
//    NSLog(@"%i", substringToInt);
//    NSLog(@"Fatigue: %@", self.driversFatigue);
//    NSLog(@"Fitness: %@", self.driversFitness);
//    NSLog(@"Substance: %@", self.driversSubstance);
//    NSLog(@"Maint: %@", self.vehiclesMaint);
//    NSLog(@"Unsafe: %@", self.vehiclesUnsafe);
    return substringToInt;
    }
}

-(void)addHintView{
    UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 0.0f, 250.0f, 20.0f)];
    explainLabel.text = [NSString stringWithFormat:@"Click for explanation of pictures"];
    explainLabel.backgroundColor = [UIColor clearColor];
    explainLabel.font = [UIFont systemFontOfSize:15.0f];
    UIImageView *upArrow = [[UIImageView alloc] initWithFrame:CGRectMake(300.0f, 0.0f, 15.0f, 20.0f)];
    upArrow.image = [UIImage imageNamed:@"uparrow.png"];
    [self.containerView addSubview:explainLabel];
    [self.containerView addSubview:upArrow];
    
    [self performSelector:@selector(removeHintViews:) withObject:explainLabel afterDelay:3.0f];
    [self performSelector:@selector(removeHintViews:) withObject:upArrow afterDelay:3.0f];

}
-(void)removeHintViews:(UIView *)viewToRemove{
    
    [viewToRemove removeFromSuperview];
}

-(NSInteger)checkForZero:(NSInteger)intPassedFromOtherPlace{
    NSLog(@"%i", intPassedFromOtherPlace);
    if(intPassedFromOtherPlace == 0){
        return 1;
    }else{
        return intPassedFromOtherPlace;
    }
}

-(NSUInteger)convertToImageValue:(NSInteger)intFromObj{
    if(intFromObj == -1){
        return 1;
    }else if (intFromObj == 0){
        return 0;
    }else if(intFromObj < 33){
        return 1;
    }else if (intFromObj < 66){
        return 2;
    }else {
        return 3;
    }
}

-(void)percentInfoButtonPressed:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
            [self performSegueWithIdentifier:@"toAbout" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"toAbout" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"toAbout" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"toAbout" sender:self];
            break;
        case 5:
            [self performSegueWithIdentifier:@"toAbout" sender:self];
            break;
            
        default:
            break;
    }
}

@end
