//
//  LocationlistTableViewCell.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "LocationlistTableViewCell.h"

@implementation LocationlistTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)dic
{
    _nameLbl.text = dic[@"location_name"];
    _addressLbl.text = dic[@"location_address"];

    _cityLbl.text = dic[@"location_city"];
    _stateLbl.text = dic[@"location_state"];
    _zipcodeLbl.text = dic[@"location_zip"];
    _phonenumberLbl.text = dic[@"location_phone"];
    
    if (dic[@"location_lat"] != [NSNull null])
    {
        _latLbl.text = dic[@"location_lat"];
    }
    else
        _latLbl.text = @"no lat";
    
    if (dic[@"location_lon"] != [NSNull null])
    {
        _lonLbl.text = dic[@"location_lon"];
    }
    else
        _lonLbl.text = @"no lon";
}

@end
