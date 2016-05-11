//
//  CategorylistTableViewCell.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategorylistTableViewCell : MGSwipeTableCell

@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UILabel *publishLbl;

- (void)setData:(NSDictionary *)dic;

@end
