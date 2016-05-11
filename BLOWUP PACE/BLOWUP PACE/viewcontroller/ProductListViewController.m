//
//  ProductListViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductlistTableViewCell.h"
#import "AddProductViewController.h"

@interface ProductListViewController ()
{
    int currentPage;
    NSInteger selectedIndex;
    CarbonSwipeRefresh *refresh;

}

@property (nonatomic ,strong) NSMutableArray *productArr;
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    currentPage = 1;
    _productArr = [NSMutableArray new];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadItem];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addproductSegue"])
    {
        AddProductViewController *vc = (AddProductViewController *)[segue destinationViewController];
        if ([sender isKindOfClass:[NSNumber class]])
        {
            vc.productType = PRODUCT_EDIT;
            NSDictionary *dic = [_productArr objectAtIndex:selectedIndex];
            vc.locationId = dic[@"location_id"];
            vc.categoryId = dic[@"category_id"];
            vc.productDic =   [_productArr objectAtIndex:selectedIndex];

        }
        else
        {
            vc.productType = PRODUCT_NEW;
            vc.categoryId = _categoryDic[@"category_id"];
            vc.locationId = _locationId;

        }
    }
}

#pragma mark - UITableViewDataSource ,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductlistTableViewCell *cell = (ProductlistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"productlistCell" forIndexPath:indexPath];
    NSDictionary *dic = [_productArr objectAtIndex:indexPath.row];
    [cell setData:dic];
    
    MGSwipeButton *editBtn = [MGSwipeButton buttonWithTitle:@"Edit" backgroundColor:[UIColor lightGrayColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        // edit category
        selectedIndex = indexPath.row;
        [self performSegueWithIdentifier:@"addproductSegue" sender:@(PRODUCT_EDIT)];
        return YES;
    }];
    
    MGSwipeButton *deleteBtn = [MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell *sender) {
        
        // delete product
        
        NSDictionary *dic = [_productArr objectAtIndex:indexPath.row];
        [[APIService sharedManager] deleteProduct:dic[@"product_id"] onCompletion:^(NSDictionary *result,NSError *error){
            
            [_productArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
        }];
        
        return YES;
    }];
    
    cell.rightButtons = @[deleteBtn ,editBtn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == (_productArr.count - 1))
    {
        [self loadNextItem];
    }
}

- (void)loadItem
{
    currentPage = 1;
        
    [[APIService sharedManager] getProduct:currentPage category:_categoryDic[@"category_id"] onCompletion:^(NSDictionary *result,NSError *error){
        
        [refresh endRefreshing];

        if ([result[@"state"] isEqualToString:@"200"])
        {
            _productArr = [NSMutableArray new];;
            [_productArr addObjectsFromArray:result[@"products"]];
            [_tableView reloadData];
        }
        
    }];
}

- (void)loadNextItem
{
    currentPage++;
    
    [[APIService sharedManager] getProduct:currentPage category:_categoryDic[@"category_id"] onCompletion:^(NSDictionary *result,NSError *error){
        
        if ([result[@"state"] isEqualToString:@"200"])
        {
            if ([result[@"products"] count] > 0)
            {
                [_productArr addObjectsFromArray:result[@"products"]];
                [_tableView reloadData];
            }
        }
        
    }];
}

@end
