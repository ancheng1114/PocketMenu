//
//  LoginViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/15/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (IBAction)onLogin:(id)sender
{
    if (_emailTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please type email address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (_passwordField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please type password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"Logging in ...";
    
    [[APIService sharedManager] logIn:_emailTextField.text password:_passwordField.text onCompletion:^(NSDictionary *result,NSError *error){
        
        [hud hide:YES];
        if ([result[@"state"] isEqualToString:@"200"])
        {
            [self performSegueWithIdentifier:@"locationlistSegue" sender:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Warning" message:result[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
    }];
    
}

@end
