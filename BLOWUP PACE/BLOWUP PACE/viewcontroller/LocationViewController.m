//
//  LocationViewController.m
//  pocket menu
//
//  Created by AnCheng on 5/11/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationlistTableViewCell.h"

@interface LocationViewController ()

@property (nonatomic ,strong) NSMutableArray *locationArr;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

@end
