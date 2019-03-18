//
//  ShareDelegateManager.m
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ShareDelegateManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "UserInfoModel.h"

@implementation ShareDelegateManager

+ (instancetype)shareDelegateManager {
    static ShareDelegateManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window {
    [self registShareSDK];
}


- (void)registShareSDK {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //微信
        [platformsRegister setupWeChatWithAppId:WX_APP_ID appSecret:WX_APP_SECRET];
    }];
}

// 返回到本APP
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    NSLog(@"url:%@ option:%@",url, options);
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
            //支付宝SDK返回result 从服务器换userinfo
            if (DictIsEmpty(resultDic)) return;
            [NetWorkManager.sharedManager requestWithUrl:kLogin_alipay_auth withParameters:@{@"auth_code":resultDic[@"result"]} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                if (kStatusTrue) {
                    UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"userModel":model,@"userResp":responseObject}];
                }else {
                    [WXZTipView showTopWithText:responseObject[@"message"]];
                }
            }withFailure:^(NSError * _Nonnull error) {
                [WXZTipView showTopWithText:error.localizedDescription];
            }];
        }];
    }
    
    
    
    
    
    return YES;
}



@end
