//
//  AddmenuViewController.h
//  pocket menu
//
//  Created by AnCheng on 8/6/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@interface AddmenuViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UITextField *mailTextField;
@property (nonatomic ,assign) IBOutlet UITextField *phoneTextField;
@property (nonatomic ,assign) IBOutlet SZTextView *subjectTextView;

- (IBAction)onBack:(id)sender;
- (IBAction)sendEmail:(id)sender;

@end
