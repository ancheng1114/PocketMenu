//
//  CategoryViewController.m
//  pocket menu
//
//  Created by AnCheng on 8/4/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "ProductViewController.h"
#import "CategoryTableViewCell.h"
#import "ProductDetailViewController.h"
#import "Flurry.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self.navigationItem setHidesBackButton:YES animated:NO];
    _productArr = [NSMutableArray new];
    
    [[APIService sharedManager] getProduct:_categpryId location:_locationId onCompletion:^(NSDictionary *result,NSError *error){
        
        self.title = result[@"category_name"];
        
        _productArr = [[NSMutableArray alloc] initWithArray:result[@"products"]];
        [_poductTableView reloadData];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"productSegue"])
    {
        ProductDetailViewController *vc = (ProductDetailViewController *)[segue destinationViewController];
        vc.productDic = sender;
    }
}

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];    
    NSDictionary *dic = [_productArr objectAtIndex:indexPath.row];
    cell.nameLbl.text = dic[@"product_name"];
    cell.priceLbl.text = [NSString stringWithFormat:@"$%@" ,dic[@"product_price"]];
    cell.descriptionLbl.text = dic[@"product_description"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, dic[@"product_image"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
        
        if (!error)
            cell.thumbImageView.image = image;
        else
            cell.thumbImageView.image = [UIImage imageNamed:@"placeholder"];
        
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_productArr objectAtIndex:indexPath.row];
    
    NSDictionary *param = @{@"product" : dic[@"product_name"]};
    FlurryEventRecordStatus status = [Flurry logEvent:@"product_view" withParameters:param];
    NSLog(@"stats : %d" ,status);
    
    [self performSegueWithIdentifier:@"productSegue" sender:dic];
}

@end
