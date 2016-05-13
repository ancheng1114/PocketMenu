//
//  APIService.h
//  pocket menu
//
//  Created by AnCheng on 7/31/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIService : NSObject

+ (id)sharedManager;

typedef void(^RequestCompletionHandler)(NSDictionary *result,NSError *error);
typedef void(^RequestCompletionHandler1)(NSArray *result,NSError *error);

- (void)enterLocatinon:(double)lon lat:(double)lat onCompletion:(RequestCompletionHandler)complete;
- (void)getLocations:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete;
- (void)getLoactionInfo:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete;
- (void)getProduct:(NSString *)categoryId location:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete;
- (void)getProductInfo:(NSString *)productId onCompletion:(RequestCompletionHandler)complete;

- (void)logIn:(NSString *)email password:(NSString *)password onCompletion:(RequestCompletionHandler)complete;

// location
- (void)getLocation:(int)page onCompletion:(RequestCompletionHandler)complete;

// category
- (void)getCategory:(int)page location:(NSString *)locationId onCompletion:(RequestCompletionHandler)complete;
- (void)addCategory:(NSDictionary *)param onCompletion:(RequestCompletionHandler)complete;
- (void)editCategory:(NSDictionary *)param onCompletion:(RequestCompletionHandler)complete;
- (void)deleteCategory:(NSString *)categoryId onCompletion:(RequestCompletionHandler)complete;

// product
- (void)getProduct:(int)page category:(NSString *)categoryId onCompletion:(RequestCompletionHandler)complete;
- (void)addProduct:(NSDictionary *)param image:(NSData *)image onCompletion:(RequestCompletionHandler)complete;
- (void)editProduct:(NSDictionary *)param image:(NSData *)image onCompletion:(RequestCompletionHandler)complete;
- (void)deleteProduct:(NSString *)productId onCompletion:(RequestCompletionHandler)complete;

@end
