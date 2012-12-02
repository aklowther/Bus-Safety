//
//  SearchByCompanyViewController.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/14/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchByCompanyViewController : UITableViewController <UISearchBarDelegate> {
    NSTimer *timer;
}
@property (strong,nonatomic) NSMutableArray *filteredCompanyArray;
@property (strong,nonatomic) NSMutableArray *companyNamesArray;
@property (strong, nonatomic) NSDictionary *legalName;
@property (strong, nonatomic) NSArray *measure;
@property (nonatomic) NSArray *companyArray;
@property IBOutlet UISearchBar *companySearchBar;
@end
