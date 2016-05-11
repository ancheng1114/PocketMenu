//
//  CategoryListViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategorylistTableViewCell.h"
#import "ProductListViewController.h"
#import "AddCategoryViewController.h"

@interface CategoryListViewController ()
{
    int currentPage;
    NSInteger selectedIndex;
    CarbonSwipeRefresh *refresh;

}

@property (nonatomic ,strong) NSMutableArray *categoryArr;

@end

@implementation CategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentPage = 1;
    _categoryArr = [NSMutableArray new];
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
    
    if ([segue.identifier isEqualToString:@"productlistSegue"])
    {
        NSDictionary *dic = [_categoryArr objectAtIndex:selectedIndex];
        ProductListViewController *vc = (ProductListViewController *)[segue destinationViewController];
        vc.locationId = _locationDic[@"location_id"];
        vc.categoryDic = dic;
    }
    
    if ([segue.identifier isEqualToString:@"addcategorySegue"])
    {
        AddCategoryViewController *vc = (AddCategoryViewController *)[segue destinationViewController];
        if ([sender isKindOfClass:[NSNumber class]])
        {
            vc.catType = CATEGORY_EDIT;
            vc.categoryDic =   [_categoryArr objectAtIndex:selectedIndex];

        }
        else
        {
            vc.locationId = _locationDic[@"location_id"];
            vc.catType = CATEGORY_NEW;
        }
    }
}

#pragma mark - UITableViewDelegate ,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _categoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategorylistTableViewCell *cell = (CategorylistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"categorylistCell" forIndexPath:indexPath];
    NSDictionary *dic = [_categoryArr objectAtIndex:indexPath.row];
    [cell setData:dic];
    
    MGSwipeButton *editBtn = [MGSwipeButton buttonWithTitle:@"Edit" backgroundColor:[UIColor lightGrayColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        selectedIndex = indexPath.row;
        // edit category
        [self performSegueWithIdentifier:@"addcategorySegue" sender:@(CATEGORY_EDIT)];
        return YES;
    }];
    
    MGSwipeButton *deleteBtn = [MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        NSDictionary *dic = [_categoryArr objectAtIndex:indexPath.row];
        [[APIService sharedManager] deleteCategory:dic[@"category_id"] onCompletion:^(NSDictionary *result,NSError *error){
         
            [_categoryArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
        }];
        // delete category
        return YES;
    }];
    
    cell.rightButtons = @[deleteBtn ,editBtn];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == (_categoryArr.count - 1))
    {
        [self loadNextItem];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"productlistSegue" sender:nil];
}

- (void)loadItem
{
    currentPage = 1;

    [[APIService sharedManager] getCategory:currentPage location:_locationDic[@"location_id"] onCompletion:^(NSDictionary *result,NSError *error){

        [refresh endRefreshing];

        if ([result[@"state"] isEqualToString:@"200"])
        {
            [_categoryArr removeAllObjects];
            [_categoryArr addObjectsFromArray:result[@"categories"]];
            [_tableView reloadData];
        }
        
    }];
}

- (void)loadNextItem
{
    currentPage++;
    
    [[APIService sharedManager] getCategory:currentPage location:_locationDic[@"location_id"] onCompletion:^(NSDictionary *result,NSError *error){
        
        if ([result[@"state"] isEqualToString:@"200"])
        {
            if ([result[@"categories"] count] > 0)
            {
                [_categoryArr addObjectsFromArray:result[@"categories"]];
                [_tableView reloadData];
            }
        }
        
    }];
}

@end
