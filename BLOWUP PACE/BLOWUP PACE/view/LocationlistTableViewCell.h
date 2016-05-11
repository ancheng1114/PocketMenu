//
//  LocationlistTableViewCell.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationlistTableViewCell : UITableViewCell

@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UILabel *addressLbl;
@property (nonatomic ,assign) IBOutlet UILabel *cityLbl;
@property (nonatomic ,assign) IBOutlet UILabel *stateLbl;
@property (nonatomic ,assign) IBOutlet UILabel *zipcodeLbl;
@property (nonatomic ,assign) IBOutlet UILabel *phonenumberLbl;

@property (nonatomic ,assign) IBOutlet UILabel *latLbl;
@property (nonatomic ,assign) IBOutlet UILabel *lonLbl;


- (void)setData:(NSDictionary *)dic;

@end
