//
//  ProductViewController.h
//  pocket menu
//
//  Created by AnCheng on 8/4/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface ProductDetailViewController : UIViewController

@property (nonatomic ,strong) NSString *productId;

@property (nonatomic ,assign) IBOutlet UILabel *nameLbl;
@property (nonatomic ,assign) IBOutlet UILabel *priceLbl;
@property (nonatomic ,assign) IBOutlet UIImageView *thumbImageView;
@property (nonatomic ,assign) IBOutlet UITextView *descriptionLbl;

@property (nonatomic ,assign) IBOutlet RateView *rateView;

@property (nonatomic ,strong) NSDictionary *productDic;

@end
