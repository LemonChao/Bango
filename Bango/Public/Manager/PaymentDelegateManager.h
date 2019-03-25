//
//  PaymentDelegateManager.h
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>


NS_ASSUME_NONNULL_BEGIN

@interface PaymentDelegateManager : NSObject

@property (nonatomic, copy) void(^payFinish)(int respCode);

@property (nonatomic, copy) void(^loginFinish)(id resp);

+ (instancetype)sharedPaymentManager;

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window;

// 授权登录后返回到本APP
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

/**
 微信支付
 
 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)wechatPayWithParams:(NSDictionary *)dataDict finish:(void (^)(int))payFinish;

/**
 支付宝支付
 
 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)alipayPaycompleteParams:(NSDictionary *)dataDict payFinish:(void (^)(int))payFinish;


/**
 支付宝第三方登录
 
 @param auth_V2WithInfo 授权码
 */
- (void)loginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo;

// v1.0.1 后续版本可删除
- (void)v_1LoginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo loginFinish:(void (^)(id))loginFinish;


@end

NS_ASSUME_NONNULL_END
