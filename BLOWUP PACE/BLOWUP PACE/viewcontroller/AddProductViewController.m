//
//  AddProductViewController.m
//  pocket menu
//
//  Created by AnCheng on 3/16/16.
//  Copyright © 2016 ancheng1114. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()
{
    BOOL imageChanged;
}

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer* btnLayer = [self.descriptionTextView layer];
    [btnLayer setBorderColor:[UIColor colorWithHexString:@"#d4d4d4"].CGColor];
    btnLayer.borderWidth = 1.0f;
    btnLayer.cornerRadius = 2.0f;
    
    _thumbImageView.layer.masksToBounds = YES;

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTakePhoto)];
    singleTap.numberOfTapsRequired = 1;
    [_thumbImageView setUserInteractionEnabled:YES];
    [_thumbImageView addGestureRecognizer:singleTap];

    if (_productType == PRODUCT_EDIT)
    {
        self.title = @"Edit Product";

        _nameTextField.text = _productDic[@"product_name"];
        _priceTextField.text = _productDic[@"product_price"];
        _descriptionTextView.text = _productDic[@"product_description"];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@"  ,API_URL , IMAGE_URL, _productDic[@"product_image"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL){
            
            if (!error)
                _thumbImageView.image = image;
            else
                _thumbImageView.image = [UIImage imageNamed:@"placeholder"];
            
        }];
    }
    else
    {
        
    }
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

- (IBAction)onAdd:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Uploading ...";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
    
    if (_productType == PRODUCT_EDIT)
    {
        NSData *imageData = UIImageJPEGRepresentation(_thumbImageView.image, 0.5);
        
        NSDictionary *param = @{@"prod_id" : _productDic[@"product_id"] , @"prod_name" : _nameTextField.text  ,@"prod_price" : _priceTextField.text ,@"prod_description" : _descriptionTextView.text};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:PRODUCT_EDIT_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:imageData name:@"prod_image" fileName:[NSString stringWithFormat:@"product_%@.jpg" ,[dateFormat stringFromDate:[NSDate date]]] mimeType:@"image/jpeg"];
            
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFJSONResponseSerializer *serialize = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        serialize.acceptableContentTypes = [serialize.acceptableContentTypes setByAddingObject:@"text/html"];
        manager.responseSerializer = serialize;
        
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          // This is not called back on the main queue.
                          // You are responsible for dispatching to the main queue for UI updates
                          dispatch_async(dispatch_get_main_queue(), ^{
                              //Update the progress view
                              //[progressView setProgress:uploadProgress.fractionCompleted];
                              hud.progress = uploadProgress.fractionCompleted;
                          });
                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                          
                          [hud hide:YES];
                          [self.navigationController popViewControllerAnimated:YES];
                          
                          if (error) {
                              NSLog(@"Error: %@", error);
                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                          }
                          
                      }];
        
        [uploadTask resume];
    }
    else
    {
        
        NSData *imageData = UIImageJPEGRepresentation(_thumbImageView.image, 0.5);
        
        NSDictionary *param = @{@"loc_id" : _locationId , @"cat_id" : _categoryId , @"prod_name" : _nameTextField.text  ,@"prod_price" : _priceTextField.text ,@"prod_description" : _descriptionTextView.text};
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:PRODUCT_ADD_URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileData:imageData name:@"prod_image" fileName:[NSString stringWithFormat:@"product_%@.jpg" ,[dateFormat stringFromDate:[NSDate date]]] mimeType:@"image/jpeg"];
            
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFJSONResponseSerializer *serialize = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        serialize.acceptableContentTypes = [serialize.acceptableContentTypes setByAddingObject:@"text/html"];
        manager.responseSerializer = serialize;
        
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager
                      uploadTaskWithStreamedRequest:request
                      progress:^(NSProgress * _Nonnull uploadProgress) {
                          // This is not called back on the main queue.
                          // You are responsible for dispatching to the main queue for UI updates
                          dispatch_async(dispatch_get_main_queue(), ^{
                              //Update the progress view
                              //[progressView setProgress:uploadProgress.fractionCompleted];
                              hud.progress = uploadProgress.fractionCompleted;
                          });
                      }
                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                          
                          [hud hide:YES];
                          [self.navigationController popViewControllerAnimated:YES];

                          if (error) {
                              NSLog(@"Error: %@", error);
                          } else {
                              NSLog(@"%@ %@", response, responseObject);
                          }
                          
                      }];
        
        [uploadTask resume];
    }
}

- (void)onTakePhoto
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // Distructive button tapped.
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id) self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id) self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate ,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    _thumbImageView.image = chosenImage;
    imageChanged = YES;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
