//
//  AddProductViewController.h
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    PRODUCT_NEW = 0,
    PRODUCT_EDIT
    
}ProductType;

@interface AddProductViewController : UIViewController <UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property (nonatomic ,assign) IBOutlet UIImageView *thumbImageView;
@property (nonatomic ,assign) IBOutlet UITextField *nameTextField;
@property (nonatomic ,assign) IBOutlet UITextField *priceTextField;
@property (nonatomic ,assign) IBOutlet UITextView  *descriptionTextView;

@property (nonatomic) ProductType productType;
@property (nonatomic ,strong) NSString *locationId;
@property (nonatomic ,strong) NSString *categoryId;

@property (nonatomic ,strong) NSDictionary *productDic;

- (IBAction)onAdd:(id)sender;

@end
