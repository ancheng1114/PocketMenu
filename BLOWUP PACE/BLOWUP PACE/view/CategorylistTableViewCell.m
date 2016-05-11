//
//  CategorylistTableViewCell.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "CategorylistTableViewCell.h"

@implementation CategorylistTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)dic
{
    _nameLbl.text = dic[@"category_name"];
    _publishLbl.text = ([dic[@"ispublish"] isEqualToString:@"1"]) ? @"published" : @"unpblished";
    
}

@end
