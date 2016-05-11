//
//  ProductlistTableViewCell.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductlistTableViewCell : MGSwipeTableCell

@property (nonatomic ,assign) IBOutlet UIImageView *thumbImageView;

@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UILabel *priceLbl;
@property (nonatomic ,assign) IBOutlet UILabel *descriptionLbl;
@property (nonatomic ,assign) IBOutlet UILabel *locationLbl;

- (void)setData:(NSDictionary *)dic;

@end
