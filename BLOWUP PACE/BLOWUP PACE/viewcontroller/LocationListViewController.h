//
//  LocationListViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationListViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,assign) IBOutlet UITableView *tableView;

@end
