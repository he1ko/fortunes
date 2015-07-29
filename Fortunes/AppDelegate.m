//
//  AppDelegate.m
//  Fortunes
//
//  Created by Heiko Bublitz on 20.07.15.
//  Copyright (c) 2015 Jemix. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "CenterViewController.h"
#import "NavController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {

@private
    LeftViewController *vCLeft;
}


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    vCLeft = [[LeftViewController alloc] init];
    CenterViewController *vCcenter = [[CenterViewController alloc] init];

    NavController *navController = [[NavController alloc] initWithRootViewController:vCcenter];

    MMDrawerController * drawerController = [[MMDrawerController alloc]
            initWithCenterViewController:navController
                leftDrawerViewController:vCLeft
               rightDrawerViewController:nil];

    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setMaximumLeftDrawerWidth:240.0];

    [vCLeft setFirstController:vCcenter];

    self.window.rootViewController = drawerController;

    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
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
}

@end
