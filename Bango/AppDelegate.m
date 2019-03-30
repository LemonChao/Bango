//
//  AppDelegate.m
//  Bango
//
//  Created by zchao on 2019/3/6.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegateManager.h"
#import "PaymentDelegateManager.h"
#import "ZCWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ZCWebViewController alloc]init]];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    [AppDelegateManager.sharedAppDelegateManager didFinishLaunchingWithOptions:launchOptions withWindow:self.window];
    [PaymentDelegateManager.sharedPaymentManager didFinishLaunchingWithOptions:launchOptions withWindow:self.window];
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
    [AppDelegateManager.sharedAppDelegateManager applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    return [PaymentDelegateManager.sharedPaymentManager openURL:url options:options];
}

// 通用链接
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    // 用户点击通用链接，导致APP启动，会进到这个里面
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb])
    {
        NSURL *webPageUrl = userActivity.webpageURL;
//        NSURL *webPageUrl = [NSURL URLWithString:@"https://mr-bango.cn/openapp?goods_id=82"];

        if (webPageUrl == nil) return YES;
        NSURLComponents *components = [NSURLComponents componentsWithURL:webPageUrl resolvingAgainstBaseURL:YES];
        
        if ([webPageUrl.host isEqualToString:@"mr-bango.cn"] ||[webPageUrl.host isEqualToString:@"www.mr-bango.cn"]) {
            // 是目标链接，调用Native代码，打开对应的页面
            UINavigationController *rootNavi = (UINavigationController *)self.window.rootViewController;
            ZCWebViewController *webvc = (ZCWebViewController *)rootNavi.topViewController;
            for (NSURLQueryItem *item in components.queryItems) {
                if ([item.name isEqualToString:@"goods_id"]) {
                    [webvc bridgeCallHandler:@"navigationToGoodsDetail" data:@{@"goods_id":item.value}];
                }
            }
            
        } else {
            // 不是目标链接，用Safari打开
            [[UIApplication sharedApplication] openURL:webPageUrl];
        }
    }
    
    return YES;
}


#pragma mark - RemoteNotifications
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AppDelegateManager.sharedAppDelegateManager application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [AppDelegateManager.sharedAppDelegateManager application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [AppDelegateManager.sharedAppDelegateManager application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

@end
