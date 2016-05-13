//
//  APIService.m
//  pocket menu
//
//  Created by AnCheng on 7/31/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "APIService.h"
#import "Constants.h"

@implementation APIService

+ (id)sharedManager
{
    static APIService *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

- (void)enterLocatinon:(double)lon lat:(double)lat onCompletion:(RequestCompletionHandler)complete
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSArray *locationIds = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_LOCATIONID];
    NSDictionary *params = @{@"task" : @"enterLocation" ,@"lat" : [NSNumber numberWithDouble:lat] , @"lon" : [NSNumber numberWithDouble:lon] ,@"deviceToken" : delegate.deviceToken ,@"location_id" : [locationIds componentsJoinedByString:@","]};
    
    NSLog(@"Enter Params : %@" ,params);
    
    [manager POST:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Enter Location: %@", responseObject);
        
        NSMutableArray *locationidArr = [NSMutableArray new];

        if (responseObject == nil)
        {
        }
        else
        {
            // parse
            for (NSDictionary *dic in responseObject[@"locations"])
            {
                [locationidArr addObject:dic[@"location_id"]];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:locationidArr forKey:KEY_LOCATIONID];
        complete(responseObject ,nil);
    
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
    
}

- (void)getLocations:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    if (locationId.length == 0) locationId = @"0";
    NSDictionary *params = @{@"task" : @"newLocation" ,@"location_id" : locationId};
    [manager POST:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Location: %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)getLoactionInfo:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"task" : @"getLocationInfo" ,@"location_id" : locationId};
    [manager GET:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Location: %@", responseObject);
        complete(responseObject ,nil);
    
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)getProduct:(NSString *)categoryId location:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"task" : @"getProduct" ,@"category_id" : categoryId ,@"location_id" : locationId};
    [manager GET:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Products: %@", responseObject);
        complete(responseObject ,nil);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)getProductInfo:(NSString *)productId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"task" : @"getProductDetail" ,@"product_id" : productId};
    [manager GET:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Product Detail: %@", responseObject);
        complete(responseObject ,nil);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)leaveLocation:(NSString *)statsId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"task" : @"leaveLocation" ,@"state_id" : statsId};
    [manager GET:BASE_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Product Detail: %@", responseObject);
        complete(responseObject ,nil);
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)logIn:(NSString *)email password:(NSString *)password onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"task" : @"login" ,@"email" : email ,@"password" : password};
    [manager POST:LOGIN_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Login Detail: %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)getLocation:(int)page onCompletion:(RequestCompletionHandler)complete;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"page_index" : @(page)};
    [manager GET:LOCATION_LIST_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Location : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

-(void)getCategory:(int)page location:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"page_index" : @(page) ,@"lid" : locationId};
    [manager GET:CATETORY_LIST_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Category : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)addCategory:(NSDictionary *)param onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:CATEGORY_ADD_URL parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Category Added : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)editCategory:(NSDictionary *)param onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    [manager POST:CATEGORY_EDIT_URL parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Category Edited : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)deleteCategory:(NSString *)categoryId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *param = @{@"cat_id" : categoryId};
    [manager POST:CATEGORY_DELETE_URL parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Category Deleted : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)getProduct:(int)page category:(NSString *)categoryId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *params = @{@"page_index" : @(page) ,@"cat_id" : categoryId};
    [manager GET:PRODUCT_LIST_URL parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Product : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

- (void)addProduct:(NSDictionary *)param image:(NSData *)image onCompletion:(RequestCompletionHandler)complete
{
    
}

- (void)editProduct:(NSDictionary *)param image:(NSData *)image onCompletion:(RequestCompletionHandler)complete
{
    
}

- (void)deleteProduct:(NSString *)productId onCompletion:(RequestCompletionHandler)complete
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    
    NSDictionary *param = @{@"prod_id" : productId};
    [manager POST:PRODUCT_DELETE_URL parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Product Deleted : %@", responseObject);
        complete(responseObject ,nil);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        complete(nil ,error);
        
    }];
}

@end
