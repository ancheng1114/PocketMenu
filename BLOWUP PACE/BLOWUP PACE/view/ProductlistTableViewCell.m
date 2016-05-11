//
//  ProductlistTableViewCell.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "ProductlistTableViewCell.h"

@implementation ProductlistTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _thumbImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)dic
{
    _nameLbl.text = dic[@"product_name"];
    _priceLbl.text = dic[@"product_price"];
    _locationLbl.text = dic[@"location_name"];
    _descriptionLbl.text = dic[@"product_description"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, dic[@"product_image"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
        
        if (!error)
            _thumbImageView.image = image;
        else
            _thumbImageView.image = [UIImage imageNamed:@"placeholder"];
        
    }];
    
}

@end
