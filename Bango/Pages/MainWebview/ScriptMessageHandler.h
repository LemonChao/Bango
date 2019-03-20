//
//  ScriptMessageHandler.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

NS_ASSUME_NONNULL_BEGIN

// 处理JS调用原生
@interface ScriptMessageHandler : NSObject

+ (instancetype)sharedHandler;

@property(nonatomic, strong) UIViewController *webVC;

// JS吊起原生登录
//- (void)startLogin:(WVJBResponseCallback)responseCallback;

/** app推广分享 */
-(void)shareParams:(NSDictionary *)params ResponseCallback:(WVJBResponseCallback)responseCallback;

/** 拼团的分享 */
-(void)shareURLAuthenticationParam:(NSArray *)parm;


-(BOOL)copyText:(NSString *)text;

#pragma mark ====支付宝支付====
-(void)alipayPayment:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback;
@end

NS_ASSUME_NONNULL_END
