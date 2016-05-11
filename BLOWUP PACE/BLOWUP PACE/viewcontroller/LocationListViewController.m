//
//  LocationListViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "LocationListViewController.h"
#import "LocationlistTableViewCell.h"
#import "CategoryListViewController.h"

@interface LocationListViewController ()
{
    int currentPage;
    NSInteger selectedIndex;
    CarbonSwipeRefresh *refresh;

}

@property (nonatomic ,strong) NSMutableArray *locationArr;

@end

@implementation LocationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentPage = 1;
    _locationArr = [NSMutableArray new];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.tableView];
    [refresh setColors:@[
                         [UIColor blueColor],
                         [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor greenColor]]
     ]; // default tintColor
    
    // If your ViewController extends to UIViewController
    // else see below
    [self.view addSubview:refresh];
    [refresh addTarget:self action:@selector(loadItem) forControlEvents:UIControlEventValueChanged];
        
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadItem];
    
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
    
    if ([segue.identifier isEqualToString:@"categorylistSegue"])
    {
        NSDictionary *dic = [_locationArr objectAtIndex:selectedIndex];
        CategoryListViewController *vc = (CategoryListViewController *)[segue destinationViewController];
        vc.locationDic = dic;
    }
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _locationArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationlistTableViewCell *cell = (LocationlistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"locationlistCell" forIndexPath:indexPath];
    NSDictionary *dic = [_locationArr objectAtIndex:indexPath.row];
    [cell setData:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == (_locationArr.count - 1))
    {
        [self loadNextItem];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"categorylistSegue" sender:nil];
}

- (void)loadItem
{
    currentPage = 1;
    [[APIService sharedManager] getLocation:currentPage onCompletion:^(NSDictionary *result,NSError *error){
        
        [refresh endRefreshing];
        
        if ([result[@"state"] isEqualToString:@"200"])
        {
            _locationArr = [NSMutableArray new];;
            [_locationArr addObjectsFromArray:result[@"locations"]];
            [_tableView reloadData];
        }
        
    }];
}

- (void)loadNextItem
{
    currentPage++;

    [[APIService sharedManager] getLocation:currentPage onCompletion:^(NSDictionary *result,NSError *error){
        
        if ([result[@"state"] isEqualToString:@"200"])
        {
            if ([result[@"locations"] count] > 0)
            {
                [_locationArr addObjectsFromArray:result[@"locations"]];
                [_tableView reloadData];
            }
        }
        
    }];
}

@end
