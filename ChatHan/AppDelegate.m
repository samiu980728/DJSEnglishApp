//
//  AppDelegate.m
//  ChatHan
//
//  Created by lee on 2017/12/15.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import "DJSChatViewController.h"
#import "DJSAllViewController.h"
#import "DJSSentenceViewController.h"
#import "DJSDailyyPushhViewController.h"
#import "DJSChatPeopleViewController.h"
#import "DJSLoginScreenViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate {
    UINavigationController * nav;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //把这些加到登录时间按钮按下后的点击事件中去
//    UITabBarController * tabBarController = [[UITabBarController alloc] init];
//    DJSChatViewController * viewController = [[DJSChatViewController alloc] init];
//    viewController.tabBarItem.image = [[UIImage imageNamed:@"voice.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:viewController];
//
//    DJSAllViewController * kangViewController = [[DJSAllViewController alloc] init];
//    kangViewController.tabBarItem.image = [[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:kangViewController];
//
//    DJSSentenceViewController * sentenceViewController = [[DJSSentenceViewController alloc] init];
//    sentenceViewController.tabBarItem.image = [[UIImage imageNamed:@"collection1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:sentenceViewController];
//
//    DJSDailyyPushhViewController * dailyPushViewController = [[DJSDailyyPushhViewController alloc] init];
//    dailyPushViewController.tabBarItem.image = [[UIImage imageNamed:@"1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:dailyPushViewController];
//
//    DJSChatPeopleViewController * chatViewController = [[DJSChatPeopleViewController alloc] init];
//    chatViewController.tabBarItem.image = [[UIImage imageNamed:@"1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UINavigationController * nav0 = [[UINavigationController alloc] initWithRootViewController:chatViewController];
//
//
//    NSMutableArray * controllerArray = [NSMutableArray arrayWithObjects:nav4,nav3,nav2,nav0,nil];
//    tabBarController.viewControllers = controllerArray;
//    self.window.rootViewController = tabBarController;
//    [self.window makeKeyAndVisible];
    DJSLoginScreenViewController * logInViewController = [[DJSLoginScreenViewController alloc] init];
    logInViewController.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = logInViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
