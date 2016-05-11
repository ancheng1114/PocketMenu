//
//  CategoryListViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryListViewController : UIViewController <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) NSDictionary *locationDic;
@property (nonatomic ,assign) IBOutlet UITableView *tableView;


@end
