//
//  PaymentDelegateManager.m
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "PaymentDelegateManager.h"
#import "UserInfoModel.h"
#import "UIImage+Developer.h"

@interface PaymentDelegateManager ()<WXApiDelegate>

@end

@implementation PaymentDelegateManager
{
    BOOL isLogin;
}

+ (instancetype)sharedPaymentManager {
    static PaymentDelegateManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window {
    [WXApi registerApp:WX_APP_ID];
    [self registShareSDK];
}

- (void)registShareSDK {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //微信
        [platformsRegister setupWeChatWithAppId:WX_APP_ID appSecret:WX_APP_SECRET];
        //QQ
        [platformsRegister setupQQWithAppId:QQ_APP_ID appkey:QQ_APP_SECRET];

    }];
}


// 授权登录后/支付完成 返回到本APP
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    
    NSLog(@"url:%@  urlHost:%@ urlabs:%@, options:%@", url, url.host, url.absoluteString, options);
    /**
     host
     微信支付返回 pay
     微信登录返回 oauth
     支付宝支付返回 safepay
     支付宝登录返回 safepay
     */

    if ([url.host isEqualToString:@"safepay"]) {
        if (isLogin) {
            
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                
                //支付宝SDK返回result 从服务器换userinfo
                if (DictIsEmpty(resultDic)) return;
//                if (self.loginFinish) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        // UI更新代码
//                        if (self.loginFinish) {
//                            self.loginFinish(resultDic);
//                        }
//                    });
//                    return;//v1.0.1 之前h5调用支付宝SDK登陆
//                }
                [NetWorkManager.sharedManager requestWithUrl:kLogin_alipay_auth withParameters:@{@"auth_code":resultDic[@"result"]} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"userModel":model,@"userResp":responseObject}];
                    }else {
                        [WXZTipView showCenterWithText:responseObject[@"message"]];
                    }
                }withFailure:^(NSError * _Nonnull error) {
                    [WXZTipView showCenterWithText:error.localizedDescription];
                }];
            }];
        }else {
            
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSString *code=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (self.payFinish) {
                        self.payFinish([code intValue]);
                    }
                });
            }];
        }
    }
    return [WXApi handleOpenURL:url delegate:self];
}

// 微信支付
- (void)wechatPayWithParams:(NSDictionary *)dataDict finish:(void (^)(int))payFinish {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"您还未安装微信");
        [WXZTipView showCenterWithText:@"您还未安装微信"];
        return;
    }
    isLogin = NO;
    [NetWorkManager.sharedManager requestWithUrl:kOrderinfo_weixinpay withParameters:dataDict withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        NSDictionary *orderInfo = responseObject[@"info"];
        
        if (!DictIsEmpty(orderInfo)) {
            self.payFinish = payFinish;
            PayReq *req   = [[PayReq alloc] init];
            req.openID    = [orderInfo objectForKey:@"appid"];
            req.partnerId = [orderInfo objectForKey:@"partnerid"];
            req.prepayId  = [orderInfo objectForKey:@"prepayid"];
            req.nonceStr  = [orderInfo objectForKey:@"noncestr"];
            req.timeStamp = [[orderInfo objectForKey:@"timestamp"] intValue];
            req.package   = [orderInfo objectForKey:@"package"];
            req.sign      = [orderInfo objectForKey:@"sign"];
            [WXApi sendReq:req];
        }
        
    } withFailure:^(NSError * _Nonnull error) {
        [WXZTipView showCenterWithText:error.localizedDescription];
    }];

}

//在openURL:中执行 [WXApi handleOpenURL:url delegate:self] 设置代理后，onResp会调用
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        if (self.payFinish) {
            self.payFinish(resp.errCode);
        }
    }
}



// 支付宝支付
- (void)alipayPaycompleteParams:(NSDictionary *)dataDict payFinish:(void (^)(int))payFinish {
    self.payFinish = payFinish;
    isLogin = NO;

    [NetWorkManager.sharedManager requestWithUrl:kOrderinfo_alipay withParameters:dataDict withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        NSString *dataString = responseObject[@"info"];
        if (![NSString isNOTNull:dataString]) {
            [[AlipaySDK defaultService] payOrder:dataString fromScheme:@"BanGuoAlipay" callback:^(NSDictionary *resultDic) {
                NSLog(@"==============================reslut = %@",resultDic);
                NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
                payFinish([resultStatus intValue]);
            }];
        }else {
            [WXZTipView showCenterWithText:responseObject[@"mas"] ];
        }
        
    } withFailure:^(NSError * _Nonnull error) {
        [WXZTipView showCenterWithText:error.localizedDescription];
    }];
    
}

// 支付宝登陆步骤2 唤起支付宝 authcode换token以及d用户信息

-(void)loginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo {
    isLogin = YES;
    // this callback is invaild 需要调用方在appDelegate中调用processAuth_V2Result:standbyCallback:方法获取授权结果
    [[AlipaySDK defaultService] auth_V2WithInfo:auth_V2WithInfo fromScheme:@"BanGuoAlipay" callback:nil];

}

//// v1.0.1 后续版本可删除
//- (void)v_1LoginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo loginFinish:(void (^)(id))loginFinish {
//    self.loginFinish  = loginFinish;
//    isLogin = YES;
//    [[AlipaySDK defaultService] auth_V2WithInfo:auth_V2WithInfo fromScheme:@"BanGuoAlipay" callback:nil];
//
//}
@end
