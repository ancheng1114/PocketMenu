//
//  LocationViewController.h
//  pocket menu
//
//  Created by AnCheng on 8/1/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,assign) IBOutlet UITableView *categoyTableView;
@property (nonatomic ,assign) IBOutlet UILabel *noitemLbl;
@property (nonatomic ,strong) NSString *locationId;

@property (nonatomic ,strong) NSMutableArray *categoyArr;

- (void)getLocation:(NSString *)locationId;

@end
