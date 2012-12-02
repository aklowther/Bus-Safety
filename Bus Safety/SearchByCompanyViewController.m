//
//  SearchByCompanyViewController.m
//  Bus Safety
//
//  Created by Adam Lowther on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//
#define companyQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define LABEL_WIDTH 80
#define LABEL_HEIGHT 20

#import "SearchByCompanyViewController.h"
#import "companyCellControllerCell.h"
#import "companyObject.h"
#import "companyDetailViewController.h"

@interface SearchByCompanyViewController ()
@property (nonatomic, retain) UIView *activityView;
@property (nonatomic) NSString *driverFatigue;
@property (nonatomic) NSString *driverFitness;
@property (nonatomic) NSString *driverSubstance;
@property (nonatomic) NSString *vehicleMaint;
@property (nonatomic) NSString *vehicleUnsafe;
@property (nonatomic, strong) NSDictionary *json;
@end

@implementation SearchByCompanyViewController
@synthesize filteredCompanyArray = _filteredCompanyArray;
@synthesize companyArray = _companyArray;
@synthesize companySearchBar = _companySearchBar;
@synthesize legalName = _legalName;
@synthesize companyNamesArray = _companyNamesArray;
@synthesize activityView, measure, json;
//@synthesize noReturedResults = _noReturedResults;
int returnAnyResutls = 1;
BOOL searchHasRun;
UIAlertView *alert = nil;


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = FALSE;
//}
- (void)viewDidLoad
{

    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"Search Company"];
    [self setUpActivityView];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    dispatch_async(companyQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://mobile.fmcsa.dot.gov/saferbus/resource/v1/carriers/aa.json?start=1&size=10&webKey=e43fb72f0ae6a24460353ec879f1e81255123b04"]];
        [self fetchedData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView reloadData];
        });
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)companySearchBar {
    [self handleSearch:companySearchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)companySearchBar {
    [self handleSearch:companySearchBar];
}

- (void)handleSearch:(UISearchBar *)companySearchBar {
    //NSLog(@"User searched for %@", companySearchBar.text);
    if (companySearchBar.text.length < 2 && companySearchBar.text.length != 0){
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please enter atleast 2 characters without spaces or punctuation"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else{
        NSString *partOneOfURL = @"https://mobile.fmcsa.dot.gov/saferbus/resource/v1/carriers/";
        NSString *partTwoOfURL = @".json?start=1&size=10&webKey=e43fb72f0ae6a24460353ec879f1e81255123b04";
        NSString *newCompanySearch = nil;
        @try {
            newCompanySearch = [companySearchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        }
        @catch (NSException *exception) {
            NSLog(@"Error:%@", exception);
            newCompanySearch = companySearchBar.text;
        }
        @finally {
            //NSLog(@"worked");
        }
    NSString *newURL = [NSString stringWithFormat:@"%@%@%@", partOneOfURL, newCompanySearch, partTwoOfURL];
        [self.view addSubview:self.activityView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    dispatch_async(companyQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:newURL]];
        [self fetchedData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self.view.subviews lastObject] removeFromSuperview];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView reloadData];
        });
    });
//        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:newURL]];
//        [self fetchedData:data];
        searchHasRun = YES;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
//            [companySearchBar resignFirstResponder];
//            CGRect newBounds = self.tableView.bounds;
//            newBounds.origin.y = newBounds.origin.y;
//            self.tableView.bounds = newBounds;
//        }
//
////    CGRect newBounds = self.tableView.bounds;
////    newBounds.origin.y = newBounds.origin.y + companySearchBar.bounds.size.height;
////    self.tableView.bounds = newBounds;
        if (returnAnyResutls == 2 && searchHasRun == YES){
        alert = [[UIAlertView alloc] initWithTitle:nil
                                           message:@"No Results Returned"
                                          delegate:nil
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
            [alert show];
            [self performSelector:@selector(closeNoResultsAlert:) withObject:alert afterDelay:3.0];
        }
    [companySearchBar resignFirstResponder];
        
    }
}

-(void)closeNoResultsAlert:(UIAlertView *)x{
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error = nil;
    @try {
        self.json = [NSJSONSerialization JSONObjectWithData:responseData
                                                             options:kNilOptions
                                                               error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"Error:%@", exception);
        self.json = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"errorHandle" ofType:@"json"]];
    }
    NSDictionary *carriersJSON = [self.json objectForKey:@"Carriers"];
        self.companyArray = [carriersJSON objectForKey:@"Carrier"];
        if (self.companyArray == NULL){
            returnAnyResutls = 2;
            //NSLog(@"%x", returnAnyResutls);
        }else{
            returnAnyResutls = 1;
            //NSLog(@"%x", returnAnyResutls);
            
        }
        self.companyNamesArray = [NSMutableArray array];
        NSDictionary *measureBreakdown = nil;
        for (int i = 0; i < [self.companyArray count]; i++)
        {
            self.legalName = [self.companyArray objectAtIndex:i];
            //NSLog(@"%@",self.legalName);
            if ([[self.legalName objectForKey:@"allowToOperate"] characterAtIndex:0] == 89) {
                self.measure = [self.legalName objectForKey:@"CarrierMeasure"];
                if (self.measure != NULL) {
                    for (int j = 0; j < 5; j++) {
                        @try {
                            measureBreakdown = [self.measure objectAtIndex:j];
                        }
                        @catch (NSException *exception) {
                            //NSLog(@"objectAtIndex:]: unrecognized selector sent to instance");
                        }
                        @finally {
                            //NSLog(@"Good");
                        }
                        //NSLog(@"%@", measureBreakdown);
                        NSDictionary *basic = [measureBreakdown objectForKey:@"basic"];
                        NSString *basicID = [basic objectForKey:@"@basicId"];
                        //NSUInteger basicID = [basic objectForKey:@"basicId"];
                        //NSLog(@"BASIC: %@", basicID);
                        NSString *tempPercentile = [measureBreakdown objectForKey:@"percentile"];
                        //                NSLog(@"Percentile: %@", tempPercentile);
                        if ([basicID characterAtIndex:0] == 49) {
                            self.vehicleUnsafe = tempPercentile;
                        }if ([basicID characterAtIndex:0] == 50){
                            self.driverFatigue = tempPercentile;
                        }if ([basicID characterAtIndex:0] == 51){
                            self.driverFitness = tempPercentile;
                        }if ([basicID characterAtIndex:0] == 52){
                            self.driverSubstance = tempPercentile;
                        }if ([basicID characterAtIndex:0] == 53){
                            self.vehicleMaint = tempPercentile;
                        }
                        //                if (basicID == 1) {
                        //                    self.vehicleUnsafe = tempPercentile;
                        //                }else if (basicID == 2){
                        //                    self.driverFatigue = tempPercentile;
                        //                }else if (basicID == 3){
                        //                    self.driverFitness = tempPercentile;
                        //                }else if (basicID == 4){
                        //                    self.driverSubstance = tempPercentile;
                        //                }else if (basicID == 5){
                        //                    self.vehicleMaint = tempPercentile;
                        //                }
                    }
                }
            }
            [self.companyNamesArray addObject:[companyObject companyName:[self.legalName objectForKey:@"legalName"] isItAllowed:[self.legalName objectForKey:@"allowToOperate"] driverFatigue:self.driverFatigue driverFitness:self.driverFitness driverSubstance:self.driverSubstance vehicleMaint:self.vehicleMaint vehicleUnsafe:self.vehicleUnsafe]];
        }
}



- (void)searchBarCancelButtonClicked:(UISearchBar *) companySearchBar {
    NSLog(@"User canceled search");
    [companySearchBar resignFirstResponder];
//    CGRect newBounds = self.tableView.bounds;
//    newBounds.origin.y = newBounds.origin.y + companySearchBar.bounds.size.height;
//    self.tableView.bounds = newBounds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.companyNamesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StaffSearchCell";
    companyCellControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[companyCellControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    //cell.companyLabel.text = [_companyNamesArray objectAtIndex:indexPath.row];
    
    companyObject *newCompany = nil;
    newCompany = [_companyNamesArray objectAtIndex:indexPath.row];
    cell.companyLabel.text = newCompany.name;
    if ([newCompany.allowedToOperate characterAtIndex:0] == 89)
    {
        cell.allowedToOperateImage.image = [UIImage imageNamed:@"go.png"];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        cell.allowedToOperateImage.image = [UIImage imageNamed:@"stop.png"];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


//#pragma mark - TableView Delegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self performSegueWithIdentifier:@"companyDetail" sender:tableView];
//}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"companyDetail"]) {
        companyDetailViewController *companyDetailView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        companyObject *newCompany = [self.companyNamesArray objectAtIndex:indexPath.row];
        //NSLog(@"NEWCOMPANY: %@", newCompany.fatiguedRecord);
        NSString *destinationTitle = newCompany.name;
        companyDetailView.driversFatigue = newCompany.fatiguedRecord;
        companyDetailView.driversFitness = newCompany.fitnessRecord;
        companyDetailView.driversSubstance = newCompany.substanceRecord;
        companyDetailView.vehiclesMaint = newCompany.maintRecord;
        companyDetailView.vehiclesUnsafe = newCompany.unsafeRecord;
        companyDetailView.allowedToOperate = newCompany.allowedToOperate;
        //NSLog(@"companyUnsafe: %@, objUnsafe: %@", companyDetailView.vehiclesUnsafe, newCompany.unsafeRecord);
        [companyDetailView setTitle:destinationTitle];
        
    }
}

- (void)setUpActivityView
{
    
    self.activityView = [[UIView alloc] initWithFrame:CGRectMake(80.0f, 80.0f, 20.0f, 80.0f)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((activityView.bounds.size.width-LABEL_WIDTH)/2+20,
                                                               (activityView.bounds.size.height-LABEL_HEIGHT)/2, LABEL_WIDTH, LABEL_HEIGHT)];
    
    label.text = @"Loading…";
    label.textColor = [UIColor whiteColor];
    label.center = activityView.center;
    label.backgroundColor = [UIColor clearColor];
    UIImageView *blueBox = [[UIImageView alloc] initWithFrame:CGRectMake(-15.0f, 70.0f, 200.0f, 100.0f)];
    blueBox.image = [UIImage imageNamed:@"blueSquare"];
    //blueBox.alpha = .9;
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(label.frame.origin.x - LABEL_HEIGHT - 5,label.frame.origin.y,LABEL_HEIGHT,LABEL_HEIGHT);
    [spinner startAnimating];
    [activityView addSubview:blueBox];
    [activityView addSubview: spinner];
    [activityView addSubview: label];
}

@end
