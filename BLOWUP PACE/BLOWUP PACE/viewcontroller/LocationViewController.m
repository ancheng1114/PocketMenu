//
//  LocationViewController.m
//  pocket menu
//
//  Created by AnCheng on 5/11/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationlistTableViewCell.h"
#import "CategoryViewController.h"
#import "Flurry.h"

@interface LocationViewController ()

@property (nonatomic ,strong) NSMutableArray *locationArr;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Flurry logAllPageViewsForTarget:self.navigationController];

    _locationArr = [NSMutableArray new];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatedLocation:) name:@"updateLocation" object:delegate.locationTracker];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationEnteredForeground:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    if ([segue.identifier isEqualToString:@"locationSegue"])
    {
        CategoryViewController *vc = (CategoryViewController *)[segue destinationViewController];
        vc.locationId = sender;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_locationArr objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"locationSegue" sender:dic[@"location_id"]];
}

#pragma mark - NSNotification
- (void)updatedLocation:(NSNotification *)notification
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateLocation" object:delegate.locationTracker];
    
    NSNumber *lat = [[notification userInfo] valueForKey:@"latitude"];
    NSNumber *lng = [[notification userInfo] valueForKey:@"longitude"];
    //NSLog(@"Send to Server: Latitude(%f) Longitude(%f)", lat.doubleValue, lng.doubleValue);
    
    [[APIService sharedManager] enterLocatinon:lng.doubleValue lat:lat.doubleValue onCompletion:^(NSDictionary *result,NSError *error){
        
        
    }];
    
}

- (void)applicationEnteredForeground:(NSNotification *)notification {
    NSLog(@"Application Entered Foreground");
    
    [self getLocations];

}

- (void)getLocations
{
    NSArray *locationIds = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOCATIONID];
    [[APIService sharedManager] getLocations:[locationIds componentsJoinedByString:@","] onCompletion:^(NSDictionary *result,NSError *error){
        
        [_locationArr removeAllObjects];
        if ([result isKindOfClass:[NSDictionary class]])
            [_locationArr addObjectsFromArray:result[@"locations"]];
        [_tableView reloadData];
        
    }];
}

@end
