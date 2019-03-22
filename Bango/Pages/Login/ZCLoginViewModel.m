//
//  ZCLoginViewModel.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCLoginViewModel.h"
#import <ShareSDK/ShareSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "PaymentDelegateManager.h"

@implementation ZCLoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        UserInfoModel *model = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
        if ([model.loginType isEqualToString:@"0"]) {
            self.loginType = model.loginType;
            self.loginBtnTitle = @"微信快捷登录";
        }else if ([model.loginType isEqualToString:@"1"]) {
            self.loginType = model.loginType;
            self.loginBtnTitle = @"支付宝快捷登录";
        }else {
            self.loginType = @"2";
            self.loginBtnTitle = @"登录";
        }
    }
    return self;
}

- (RACCommand *)authCodeCmd {
    if (!_authCodeCmd) {
        _authCodeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kLogin_sendcode withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        [subscriber sendNext:@(1)];
                    }else {
                        [WXZTipView showTopWithText:responseObject[@"message"]];
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _authCodeCmd;
}


- (RACCommand *)phoneCmd {
    if (!_phoneCmd) {
        _phoneCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kLogin_index withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    
                    if (kStatusTrue) {
                        UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"userModel":model,@"userResp":responseObject}];
                        [subscriber sendNext:@(1)];
                    }else {
                        [WXZTipView showTopWithText:responseObject[@"message"]];
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _phoneCmd;
}

// 支付宝登陆步骤1 获取加密字符串含authcode
- (RACCommand *)zhifubaoCmd {
    if (!_zhifubaoCmd) {
        _zhifubaoCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kLogin_alipay withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    
                    if (kStatusTrue) {
                        [PaymentDelegateManager.sharedPaymentManager loginAlipayPaycompleteParams:responseObject[@"data"]];
                        [subscriber sendNext:@(1)];
                    }else {
                        [WXZTipView showTopWithText:responseObject[@"message"]];
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _zhifubaoCmd;
}

- (RACCommand *)wechatCmd {
    if (!_wechatCmd) {
        _wechatCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                    if (state == SSDKResponseStateSuccess){
                        NSDictionary *dataDict = @{@"type":@"0",
                                                   @"uid":user.uid,
                                                   @"nickname":user.nickname,
                                                   @"user_headimg":user.icon,
                                                   @"sex":[NSString stringWithFormat:@"%ld",(long)user.gender]
                                                   };
                        
//                        [WXZTipView showCenterWithText:@"微信授权成功"];

                        // 注册到自己服务器 并获取用户信息
                        [NetWorkManager.sharedManager requestWithUrl:kLogin_third withParameters:dataDict withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                            if (kStatusTrue) {
                                UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
                                [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"userModel":model,@"userResp":responseObject}];
                                [subscriber sendNext:@(1)];
                            }else {
                                [WXZTipView showCenterWithText:responseObject[@"message"]];
                                [subscriber sendNext:@(0)];
                            }
                            [subscriber sendCompleted];
                        } withFailure:^(NSError * _Nonnull error) {
                            [WXZTipView showCenterWithText:error.localizedDescription];
                            [subscriber sendError:error];
                        }];

                    }else{
                        [WXZTipView showCenterWithText:@"微信授权失败"];
                        [subscriber sendError:error];
                    }
                }];
               return nil;
            }];
        }];
    }
    return _wechatCmd;
}

// 用户个人资料
- (RACCommand *)personDataCmd {
    if (!_personDataCmd) {
        _personDataCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                UserInfoModel *origModel = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                
                if ([origModel.asstoken isEmptyString]) {
                    [subscriber sendCompleted];
                    return nil;
                }
                
                [NetWorkManager.sharedManager requestWithUrl:kMember_personData withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject];
                        model.asstoken = origModel.asstoken;
                        model.txPwdStatus = origModel.txPwdStatus;
                        model.loginType = origModel.loginType;
                        model.loginNum = origModel.loginNum;
                        model.avatar = origModel.avatar;
                        [BaseMethod saveObject:model withKey:UserInfo_UDSKEY];
                        [subscriber sendNext:@(1)];
                    }else {
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _personDataCmd;
}



@end
