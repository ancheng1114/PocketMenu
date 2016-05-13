//
//  LocationViewController.m
//  pocket menu
//
//  Created by AnCheng on 8/1/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "CategoryViewController.h"
#import "ProductViewController.h"
#import "LocationTableViewCell.h"
#import "Flurry.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    _categoyArr = [NSMutableArray new];
    //[self performSelector:@selector(selector) withObject:nil afterDelay:3.0f];

    
    [self getLocation:_locationId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"categorySegue"])
    {
        ProductViewController *vc = (ProductViewController *)[segue destinationViewController];
        vc.locationId = _locationId;
        vc.categpryId = sender;
    }
}

- (void)getLocation:(NSString *)locationId
{
    _locationId = locationId;
    [[APIService sharedManager] getLoactionInfo:locationId onCompletion:^(NSDictionary *result,NSError *error){
        
        if (![result[@"location_id"] isEqualToString:@"0"])
        {
            self.title = result[@"location_name"];
            
            if ([result[@"categories"] isKindOfClass:[NSArray class]])
            {
                _categoyArr = [[NSMutableArray alloc] initWithArray:result[@"categories"]];
                [_categoyTableView reloadData];
                _categoyTableView.hidden = NO;
                _noitemLbl.hidden = YES;
            }
            
        }
        else
        {
            self.title = @"Venue";
            _noitemLbl.hidden = NO;
            _categoyTableView.hidden = YES;
        }
    }];
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categoyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    NSDictionary *dic = [_categoyArr objectAtIndex:indexPath.row];
    cell.nameLbl.text = dic[@"category_name"];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSLog(@"Image Url : %@" ,[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, dic[@"category_image"]]);
    
    [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, dic[@"category_image"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
        
        if (!error)
            cell.thumbImageView.image = image;
        else
            cell.thumbImageView.image = [UIImage imageNamed:@"placeholder"];
        
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_categoyArr objectAtIndex:indexPath.row];
    
    NSDictionary *param = @{@"category" : dic[@"category_name"]};
    FlurryEventRecordStatus status = [Flurry logEvent:@"category_view" withParameters:param];
    NSLog(@"stats : %d" ,status);
    
    [self performSegueWithIdentifier:@"categorySegue" sender:dic[@"category_id"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

@end
