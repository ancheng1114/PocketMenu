//
//  AddmenuViewController.m
//  pocket menu
//
//  Created by AnCheng on 8/6/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "AddmenuViewController.h"
#import "UIColor+HexString.h"

@interface AddmenuViewController ()

@end

@implementation AddmenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer * btnLayer = [self.subjectTextView layer];
    [btnLayer setBorderColor:[UIColor colorWithHexString:@"#d4d4d4"].CGColor];
    btnLayer.borderWidth = 1.0f;
    btnLayer.cornerRadius = 4.0f;
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

- (IBAction)onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendEmail:(id)sender
{
    if (_mailTextField.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please type email address!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if (_subjectTextView.text.length == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please type subject!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    NSDictionary *dic = @{@"email" : _mailTextField.text , @"text" : _subjectTextView.text};
    if (_phoneTextField.text.length != 0)
        dic = @{@"email" : _mailTextField.text , @"name" : [NSString stringWithFormat:@"%@ , phone number %@" ,_subjectTextView.text ,_phoneTextField.text]};
    [PFCloud callFunctionInBackground:@"email" withParameters:dic block:^(id object, NSError *error){
        
        
        if (error) NSLog(@"Error : %@" ,error.localizedDescription);
        [[[UIAlertView alloc] initWithTitle:nil message:object delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        [self.navigationController popViewControllerAnimated:YES];
        
        //NSLog(@"%@" ,object);
    }];

}

@end
