//
//  LoginViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/15/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UITextField *emailTextField;
@property (nonatomic ,assign) IBOutlet UITextField *passwordField;

- (IBAction)onLogin:(id)sender;

@end
