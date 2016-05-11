//
//  AppDelegate.m
//  BLOWUP PACE
//
//  Created by AnCheng on 7/24/15.
//  Copyright (c) 2015 ancheng1114. All rights reserved.
//

#import "AppDelegate.h"
#import "CategoryViewController.h"
#import "UIColor+HexString.h"
#import "Flurry.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"4hZMh1h4ru14hxN8Jxh0ThgQup7wc6pILNGzlbdw" clientKey:@"JUWBPPvJl1s0UtvFXZcqx99djlkL0nXzsc2OMVGM"];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:KEY_LOCATIONID];
    
    [Flurry startSession:@"56Q288CY8NXQ7YB6NQS6"];
    //[Flurry logPageView];
    
    UIAlertView * alert;
    
    //We have to make sure that the Background App Refresh is enable for the Location updates to work in the background.
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    }else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        alert = [[UIAlertView alloc]initWithTitle:@""
                                          message:@"The functions of this app are limited because the Background App Refresh is disable."
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil, nil];
        [alert show];
        
    } else{
        
        self.locationTracker = [[LocationTracker alloc]init];
        [self.locationTracker startLocationTracking];
        
        //Send the best location to server every 60 seconds
        //You may adjust the time interval depends on the need of your app.
        NSTimeInterval time = 60.0;
        self.locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                         target:self
                                       selector:@selector(updateLocation)
                                       userInfo:nil
                                        repeats:YES];
    }
    
    // Push Notification setting
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    { [application registerUserNotificationSettings:settings];
        
        [application registerForRemoteNotifications];
    }

    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],NSForegroundColorAttributeName ,
                                               [UIFont systemFontOfSize:22.0f] ,NSFontAttributeName
                                               ,nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#de001e"]];
    
    return YES;
}

-(void)updateLocation {
    [self.locationTracker updateLocationToServer];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current Installation and save it to Parse.
    //NSLog(@"deviceToken: %@", deviceToken);
    self.deviceToken = [self stringWithHexBytes:deviceToken];
    NSLog(@"Token : %@" ,self.deviceToken);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@" ,error.localizedDescription);
}

- (NSString*) stringWithHexBytes:(NSData *)data
{
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:([data length] * 2)];
    const unsigned char *dataBuffer = [data bytes];
    
    for (int i = 0; i < [data length]; ++i)
    {
        [stringBuffer appendFormat:@"%02lX", (unsigned long)dataBuffer[ i ]];
    }
    
    return stringBuffer;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"Received notification: %@", userInfo);
    
    if (application.applicationState == UIApplicationStateActive ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[userInfo[@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:3];
        
        NSString *locationId =  [[[userInfo valueForKey:@"aps"] valueForKey:@"Location"] objectForKey:@"location_id"];
        // save location id
        // compare old location id , if not same , leave location , getlocation , if same , do nothing process
        
        if (locationId != nil)
        {
            // UI refresh
            
            UINavigationController *vc = (UINavigationController *)[self.window rootViewController];
            CategoryViewController *locationVC = (CategoryViewController *) [vc.viewControllers objectAtIndex:0];
            [vc popToViewController:locationVC animated:NO];
            [locationVC getLocation:locationId];
        }
        else
        {
            UINavigationController *vc = (UINavigationController *)[self.window rootViewController];
            CategoryViewController *locationVC = (CategoryViewController *) [vc.viewControllers objectAtIndex:0];
            [vc popToViewController:locationVC animated:NO];
            locationVC.noitemLbl.hidden = NO;
            locationVC.categoyTableView.hidden = YES;
            locationVC.title = @"Venue";
            
        }
    }
    else
    {
        UINavigationController *vc = (UINavigationController *)[self.window rootViewController];
        [vc popToRootViewControllerAnimated:NO];
    }
    
}

-(void)dismissAlertView:(UIAlertView *)alertView{
    if ( alertView != nil )
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        alertView = nil;
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "GP2U.BLOWUP_PACE" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BLOWUP_PACE" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BLOWUP_PACE.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
