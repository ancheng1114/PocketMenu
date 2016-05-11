//
//  AddCategoryViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    CATEGORY_NEW = 0,
    CATEGORY_EDIT
    
}CategoryType;

@interface AddCategoryViewController : UIViewController

@property (nonatomic ,assign) IBOutlet UITextField *nameTextField;
@property (nonatomic ,assign) IBOutlet M13Checkbox *publicCheckBox;

@property (nonatomic) CategoryType catType;

@property (nonatomic ,strong) NSString *locationId;
@property (nonatomic ,strong) NSDictionary *categoryDic;

- (IBAction)onAdd:(id)sender;

@end
