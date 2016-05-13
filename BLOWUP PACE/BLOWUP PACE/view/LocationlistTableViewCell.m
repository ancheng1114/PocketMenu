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
    if (dic[@"location_name"] != [NSNull null])
        _nameLbl.text = dic[@"location_name"];
    
    if (dic[@"location_address"] != [NSNull null])
        _addressLbl.text = dic[@"location_address"];

    if (dic[@"location_city"] != [NSNull null])
        _cityLbl.text = dic[@"location_city"];
    
    if (dic[@"location_state"] != [NSNull null])
        _stateLbl.text = dic[@"location_state"];
    
    if (dic[@"location_zip"] != [NSNull null])
        _zipcodeLbl.text = dic[@"location_zip"];
    
    if (dic[@"location_phone"] != [NSNull null])
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
