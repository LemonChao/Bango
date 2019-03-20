//
//  ScriptMessageHandler.m
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ScriptMessageHandler.h"
#import "ShareObject.h"
#import "ZCLoginViewController.h"

@implementation ScriptMessageHandler

+ (instancetype)sharedHandler {
    static ScriptMessageHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[ScriptMessageHandler alloc] init];
    });
    return handler;

}

- (void)startLogin:(WVJBResponseCallback)responseCallback {
    
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.webVC presentViewController:navigationVC animated:YES completion:nil];
    
    [loginVC setLoginCallback:^(NSDictionary * _Nonnull userInfo) {
        responseCallback(userInfo);
    }];
}

/** app推广分享 */
-(void)shareParams:(NSDictionary *)params ResponseCallback:(WVJBResponseCallback)responseCallback {
    if (DictIsEmpty(params)) return;
    [ShareObject.sharedObject appShareWithParams:params];
    
}

/** 拼团的分享 */
-(void)shareURLAuthenticationParam:(NSArray *)parm {
    
    NSDictionary *parms = parm[0];
    if (DictIsEmpty(parms)) return;
    
    [ShareObject.sharedObject groupShareWithText:parms[@"description"] images:parms[@"imgSrc"] url:parms[@"shareAddress"] title:parms[@"title"]];
    
}

-(BOOL)copyText:(NSString *)text {
    if ([NSString isNOTNull:text]) {
        [WXZTipView showCenterWithText:@"复制失败" duration:3];
        return NO;
    }
    [WXZTipView showCenterWithText:@"复制成功"  duration:3];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
    return  YES;
}

/** 支付宝支付 */
-(void)alipayPayment:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback {
    NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay://"];
    if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        [WXZTipView showCenterWithText:@"检测到您的手机没有支付宝软件，暂无法支付"];
        return;
    }
    if (parm.count==0||parm == nil) {
        [WXZTipView showCenterWithText:@"暂无获取订单相关内容，暂无法支付"];
        return;
    }
    NSString *orderID = parm[0];

}

@end
