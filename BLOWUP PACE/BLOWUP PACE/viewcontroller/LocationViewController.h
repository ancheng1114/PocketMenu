//
//  LocationViewController.h
//  pocket menu
//
//  Created by AnCheng on 5/11/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,assign) IBOutlet UITableView *tableView;

- (void)getLocations;

@end
