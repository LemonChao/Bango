//
//  AppDelegateManager.m
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "AppDelegateManager.h"
#import "ZCBaseTabBarController.h"

/** 导航栏 */
#import <WRNavigationBar/WRNavigationBar.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegateManager ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegateManager

+ (instancetype)sharedAppDelegateManager {
    static AppDelegateManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window {
    window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[ZCBaseTabBarController alloc]init]];
    
    [self handleFunction:launchOptions withWindow:window];
//    [self setNavBarAppearence];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    //设置别名推送
    [JPUSHService setAlias:@"zhengchao" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0) {
            NSLog(@"~~~~~~极光推送设置别名(%@)成功,您可以正常使用极光推送啦~~~~~~",iAlias);
        }else{
             NSLog(@"~~~~~~~~~~~~~~~极光推送设置别名失败~~~~~~~~~~~~");
        }
    } seq:0];
    
    // 删除别名只对别名推送有效，广播推送跟别名没有关系，自然无法通过这个方法屏蔽。
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        if (iResCode == 0) {
//            NSLog(@"~~~~~~%@极光推送退出成功~~~~~~",iAlias);
//        }else{
//            NSLog(@"~~~~~~~~~~~~~~~极光推送退出失败~~~~~~~~~~~~");
//        }
//    } seq:0];
}

//Optional
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber = -1;
    [JPUSHService resetBadge];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 12 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
//    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //从通知界面直接进入应用
//    }else{
//        //从通知设置界面进入应用
//    }
//}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif



// 通用链接
- (BOOL)continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    // 用户点击通用链接，导致APP启动，会进到这个里面
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb])
    {
        NSURL *url = userActivity.webpageURL;
        if (url == nil)
        {
            return YES;
        }
        NSLog(@"url.host:%@ -- url:%@", url.host, url);
        if ([url.host isEqualToString:@"mr-bango.cn"] ||[url.host isEqualToString:@"www.mr-bango.cn"]) {
            // 是目标链接，调用Native代码，打开对应的页面
            //navigation.root = a new webviewcontroller
            
        } else {
            // 不是目标链接，用Safari打开
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    
    return YES;
}

#pragma mark - PrivateMethod
- (void)handleFunction:(NSDictionary *)launchOptions withWindow:(UIWindow *)window {
    [self setupIQKeyBoard];
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    [JPUSHService setupWithOption:launchOptions appKey:JPush_AppKey
                          channel:@"App Store"
                 apsForProduction:YES];
}

-(void)setNavBarAppearence
{
    
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    //设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor whiteColor]];
//    [WRNavigationBar wr_setDefaultNavBarBackgroundImage:[self convertViewToImage:[self bgImageView]]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:NO];
}


- (void)setupIQKeyBoard {
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}


//view转为image
- (UIImage*)convertViewToImage:(UIView *)_tempView {
    CGSize s = _tempView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [_tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(UIView *)bgImageView{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HEX_COLOR(0x2f72b6).CGColor, (__bridge id)HEX_COLOR(0x2f72b6).CGColor,(__bridge id)HEX_COLOR(0x27c2ed).CGColor];
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = bgView.frame;
    [bgView.layer addSublayer:gradientLayer];
    return bgView;
}
@end
