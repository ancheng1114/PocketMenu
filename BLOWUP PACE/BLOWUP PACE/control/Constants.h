//
//  Constants.h
//  pocket menu
//
//  Created by AnCheng on 7/31/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#ifndef pocket_menu_Constants_h
#define pocket_menu_Constants_h


#define API_URL                @"http://ec2-52-27-136-172.us-west-2.compute.amazonaws.com/pocketmenu"
#define BASE_URL                @"http://ec2-52-27-136-172.us-west-2.compute.amazonaws.com/pocket/"

//#define API_URL                  @"http://192.168.1.150/pocketmenu"

#define LOGIN_URL               (API_URL @"/api/user/login")
#define LOCATION_LIST_URL        (API_URL @"/api/location")
#define CATETORY_LIST_URL        (API_URL @"/api/category")
#define PRODUCT_LIST_URL         (API_URL @"/api/product")

#define CATEGORY_ADD_URL          (API_URL @"/api/category/add")
#define CATEGORY_EDIT_URL         (API_URL @"/api/category/edit")
#define CATEGORY_DELETE_URL       (API_URL @"/api/category/delete")

#define PRODUCT_ADD_URL          (API_URL @"/api/product/add")
#define PRODUCT_EDIT_URL         (API_URL @"/api/product/edit")
#define PRODUCT_DELETE_URL       (API_URL @"/api/product/delete")


#define IMAGE_URL               @"/images/upload/"

#define GETLOCATION_TASK        @"getLoactionInfo"
#define GETPRODUCT_TASK         @"getProduct"
#define GETPRODUCT_INFO_TASK    @"getproductinfo"

#define KEY_LOCATIONID          @"LOCATION"

#endif
