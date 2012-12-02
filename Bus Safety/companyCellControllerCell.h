//
//  companyCellControllerCell.h
//  Bus Safety
//
//  Created by Adam Lowther on 10/16/12.
//  Copyright (c) 2012 Tres Muchachos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface companyCellControllerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *allowedToOperateImage;
@property (nonatomic, strong) IBOutlet UILabel *companyLabel;
@end