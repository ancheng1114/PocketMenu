//
//  AddCategoryViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "AddCategoryViewController.h"

@interface AddCategoryViewController ()

@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _publicCheckBox.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _publicCheckBox.titleLabel.text = @"Publish";
    _publicCheckBox.checkAlignment = M13CheckboxAlignmentLeft;
    _publicCheckBox.checkHeight = 18.0f;
    _publicCheckBox.radius = 1.0f;
    
    if (_catType == CATEGORY_EDIT)
    {
        self.title = @"Edit Category";
        
        _nameTextField.text = _categoryDic[@"category_name"];
        _publicCheckBox.checkState = ([_categoryDic[@"ispublish"] isEqualToString:@"1"]) ? M13CheckboxStateChecked : M13CheckboxStateUnchecked;
        
    }
    else
    {
        _publicCheckBox.checkState = M13CheckboxStateChecked;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addproductSegue"])
    {
        
    }
}

- (IBAction)onAdd:(id)sender
{
    
    if (_catType == CATEGORY_EDIT)
    {
        NSString *publish = (_publicCheckBox.checkState == M13CheckboxStateChecked) ? @"1" : @"0";
        NSDictionary *dic = @{@"cat_id" : _categoryDic[@"category_id"] , @"cat_name" : _nameTextField.text , @"cat_published" : publish};
        [[APIService sharedManager] editCategory:dic onCompletion:^(NSDictionary *result,NSError *error){
           
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    else
    {
        NSDictionary *dic = @{@"loc_id" : _locationId , @"cat_name" : _nameTextField.text};
        [[APIService sharedManager] addCategory:dic onCompletion:^(NSDictionary *result,NSError *error){
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
}

@end
