//
//  CategoryViewController.h
//  pocket menu
//
//  Created by AnCheng on 8/4/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic ,assign) IBOutlet UITableView *poductTableView;

@property (nonatomic ,strong) NSString *categpryId;
@property (nonatomic ,strong) NSString *locationId;
@property (nonatomic ,strong) NSMutableArray *productArr;

@end
