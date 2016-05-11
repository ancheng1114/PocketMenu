//
//  CategoryTableViewCell.h
//  pocket menu
//
//  Created by AnCheng on 8/4/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UILabel *priceLbl;
@property (nonatomic ,assign) IBOutlet UIImageView *thumbImageView;
@property (nonatomic ,assign) IBOutlet UITextView *descriptionLbl;

@property (nonatomic ,assign) IBOutlet UIButton *readmoreBtn;

@end
