//
//  MobilePaymentManager.h
//  healthManagement
//
//  Created by MATRIX on 15/11/20.
//  Copyright © 2015年 renqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "AppDelegate.h"
//#import "Order.h"
//#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AlipayPaymentNetApi.h"
#import "WeChatPayNetApi.h"
/**
 *  微信支付完成通知
 */
#define WECHAT_PAY_FINISH_NOTIFICATION  @"WECHAT_PAY_FINISH_NOTIFICATION"

#define WECHAT_RESP_CODE   @"wechatResponseCode"

/**
 *  移动支付管理
 */
@interface MobilePaymentManager : NSObject<WXApiDelegate>

@property (nonatomic, copy) void(^wechatPayFinish)(int respCode);

@property (nonatomic, copy) void(^loginFinish)(id resp);
+ (MobilePaymentManager *)sharedManager;

/**
 微信支付

 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)wechatPayWithParams:(NSDictionary *)dataDict
                     finish:(void (^)(int))payFinish;



/**
 支付宝支付

 @param dataDict 订单数据，包括订单ID
 @param payFinish 微信支付完成操作
 */
- (void)AlipayPaycompleteParams:(NSDictionary *)dataDict
                      payFinish:(void (^)(int))payFinish;

/**
 支付宝第三方登录

 @param auth_V2WithInfo 授权码
 @param loginFinish 回调
 */
-(void)LoginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo
                         	loginFinish:(void (^)(id))loginFinish;

/**
 回调URL

 @param url 地址
 @return 回调
 */
-(BOOL)handleOpenURL:(NSURL *)url;
@end
