//
//  MobilePaymentManager.m
//  healthManagement
//
//  Created by MATRIX on 15/11/20.
//  Copyright © 2015年 renqing. All rights reserved.
//

#import "MobilePaymentManager.h"
#import "KeyMacro.h"

@implementation MobilePaymentManager
{
    BOOL isLogin;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPayFinished:) name:WECHAT_PAY_FINISH_NOTIFICATION object:nil];
        
    }
    return self;
}
+ (MobilePaymentManager *)sharedManager
{
    static MobilePaymentManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MobilePaymentManager alloc] init];
        [WXApi registerApp:WX_APP_ID];
    });
    
    return _sharedInstance;
}
- (void)wechatPayWithParams:(NSDictionary *)dataDict
                     finish:(void (^)(int))payFinish
{
    // 检测是否安装有微信
//    if (![WXApi isWXAppInstalled]) {
//        
//    }
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"您还未安装微信");
        [WXZTipView showCenterWithText:@"您还未安装微信"];
        return;
    }
    isLogin = NO;
    WeChatPayNetApi *wePay = [[WeChatPayNetApi alloc]initWithParameter:dataDict];
    [wePay startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
         WeChatPayNetApi *payResult = (WeChatPayNetApi *)request;
        if ([[payResult getContent] isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dicResponse = (NSDictionary *)[payResult getContent];
//             NSDictionary *dicResponse = response[@"info"];
            if ([dicResponse isKindOfClass:[NSDictionary class]]){
                self->_wechatPayFinish = payFinish;
                    //调起微信支付
                PayReq *req   = [[PayReq alloc] init];
                req.openID    = [dicResponse objectForKey:@"appid"];
                req.partnerId = [dicResponse objectForKey:@"partnerid"];
                req.prepayId  = [dicResponse objectForKey:@"prepayid"];
                req.nonceStr  = [dicResponse objectForKey:@"noncestr"];
                req.timeStamp = [[dicResponse objectForKey:@"timestamp"] intValue];
                req.package   = [dicResponse objectForKey:@"package"];
                req.sign      = [dicResponse objectForKey:@"sign"];
                [WXApi sendReq:req];
            }else{
//                [WXZTipView showCenterWithText:response[@"mas"]];
            }
        }else{
            [WXZTipView showCenterWithText:@"数据请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"数据请求失败"];
    }];
}

- (void)wechatPayFinished:(NSNotification *)notification
{
    int errCode = [notification.userInfo[WECHAT_RESP_CODE] intValue];
    if (_wechatPayFinish) {
        _wechatPayFinish(errCode);
    }
}



- (void)AlipayPaycompleteParams:(NSDictionary *)dataDict  payFinish:(void (^)(int))payFinish{
     _wechatPayFinish = payFinish;
    isLogin = NO;
    AlipayPaymentNetApi *version = [[AlipayPaymentNetApi alloc]initWithParameter:dataDict];
    [version startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        AlipayPaymentNetApi *payResult = (AlipayPaymentNetApi *)request;
        if ([[payResult getContent] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *response = (NSDictionary *)[payResult getContent];
            NSString *dataString = response[@"info"];
            if (![NSString  isNOTNull:dataString]){
                NSString *appScheme = @"BanGuoAlipay";
                [[AlipaySDK defaultService] payOrder:dataString fromScheme:appScheme callback:^(NSDictionary *resultDic){
                    NSLog(@"==============================reslut = %@",resultDic);
                    NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
                    payFinish([resultStatus intValue]);
                }];

            } else{
                [WXZTipView showCenterWithText:response[@"mas"] ];
            }
            
        }else{
            [WXZTipView showCenterWithText:@"数据请求失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"数据请求失败"];
    }];
}
-(void)LoginAlipayPaycompleteParams:(NSString *)auth_V2WithInfo
                        loginFinish:(void (^)(id))loginFinish{
    _loginFinish = loginFinish;
    isLogin = YES;
    [[AlipaySDK defaultService] auth_V2WithInfo:auth_V2WithInfo fromScheme:@"BanGuoAlipay" callback:^(NSDictionary *resultDic) {
        loginFinish(resultDic);
    }];
}
/**
 *  授权回调
 */
-(BOOL)handleOpenURL:(NSURL *)url{
    
    if ([url.host isEqualToString:@"safepay"]) {
        if (isLogin) {
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                    if (self.loginFinish) {
                        self.loginFinish(resultDic);
                    }
                });
            }];
        }else{
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSString *code=[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                    if (self->_wechatPayFinish) {
                        self->_wechatPayFinish([code intValue]);
                    }
                });
                
            }];
        }
        
        return YES;
    }
    
    return [WXApi handleOpenURL:url delegate:self];
}
#pragma mark - WXApiDelegate(optional)
-(void) onReq:(BaseReq*)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
        if (_wechatPayFinish) {
            _wechatPayFinish(resp.errCode);
        }
    }
    
}

@end
