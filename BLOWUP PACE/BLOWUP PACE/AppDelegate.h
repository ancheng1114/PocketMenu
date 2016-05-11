//
//  AppDelegate.h
//  BLOWUP PACE
//
//  Created by AnCheng on 7/24/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LocationTracker.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property LocationTracker * locationTracker;
@property (nonatomic) NSTimer* locationUpdateTimer;

@property (nonatomic ,strong) NSString *deviceToken;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

