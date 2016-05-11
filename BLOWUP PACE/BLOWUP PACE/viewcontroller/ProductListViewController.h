//
//  ProductListViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,strong) NSDictionary *categoryDic;
@property (nonatomic ,strong) NSString *locationId;

@property (nonatomic ,assign) IBOutlet UITableView *tableView;

@end
