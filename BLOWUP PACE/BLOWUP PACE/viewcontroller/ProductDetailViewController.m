//
//  ProductViewController.m
//  pocket menu
//
//  Created by AnCheng on 8/4/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _rateView.starNormalColor = [UIColor clearColor];
    _rateView.starFillColor = [UIColor whiteColor];
    _rateView.starBorderColor = [UIColor whiteColor];
    _rateView.rating = 5.0f;
    _rateView.userInteractionEnabled = NO;
    _rateView.starSize = 16.0f;

    _nameLbl.text = _productDic[@"product_name"];
    _priceLbl.text = [NSString stringWithFormat:@"$%@" ,_productDic[@"product_price"]];;
    _descriptionLbl.text = _productDic[@"product_description"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, _productDic[@"product_image"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
        
        if (!error)
            _thumbImageView.image = image;
        else
            _thumbImageView.image = [UIImage imageNamed:@"placeholder"];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
