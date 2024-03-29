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
        
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:loginSuccessNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSNotification *notif) {
            
            [self.personDataCmd execute:[notif.userInfo objectForKey:@"userResp"]];
        }];
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
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
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
//                [MBProgressHUD showActivityText:@"登录中..."];
                kShowActivityText(@"登录中...")
                [NetWorkManager.sharedManager requestWithUrl:kLogin_index withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
//                        UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:loginSuccessNotification object:nil userInfo:@{@"userModel":model,@"userResp":responseObject}];
                        [self.personDataCmd execute:responseObject];

                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
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
                kShowActivityText(@"授权中...")
                [NetWorkManager.sharedManager requestWithUrl:kLogin_alipay withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    
                    if (kStatusTrue) {
                        kHidHud
                        [PaymentDelegateManager.sharedPaymentManager loginAlipayPaycompleteParams:responseObject[@"data"]];
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
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
                
                kShowActivityText(@"授权中...")
                [ShareSDK authorize:SSDKPlatformTypeWechat settings:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                    if (state == SSDKResponseStateSuccess){
                        NSDictionary *dataDict = @{@"type":@"0",
                                                   @"uid":user.uid,
                                                   @"nickname":user.nickname,
                                                   @"user_headimg":user.icon,
                                                   @"sex":[NSString stringWithFormat:@"%ld",(long)user.gender]
                                                   };
                        
                        kShowActivityText(@"登陆中...")
                        // 注册到自己服务器 并获取用户信息
                        [NetWorkManager.sharedManager requestWithUrl:kLogin_third withParameters:dataDict withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                            if (kStatusTrue) {
                                [self.personDataCmd execute:responseObject];
                                [subscriber sendNext:@(1)];
                            }else {
                                kShowMessage
                                [subscriber sendNext:@(0)];
                            }
                            [subscriber sendCompleted];
                        } withFailure:^(NSError * _Nonnull error) {
                            kShowError
                            [subscriber sendError:error];
                        }];

                    }else{
                        [MBProgressHUD showText:@"授权失败..."];
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
                UserInfoModel *origModel = [UserInfoModel modelWithDictionary:input[@"data"]];
                
                if ([origModel.asstoken isEmptyString]) {
                    [subscriber sendCompleted];
                    return nil;
                }
                kShowActivityText(@"同步中...")
                [NetWorkManager.sharedManager requestWithUrl:kMember_personData withParameters:@{@"asstoken":origModel.asstoken} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        kHidHud;
                        UserInfoModel *model = [UserInfoModel modelWithDictionary:responseObject[@"data"]];
                        model.asstoken = origModel.asstoken;
                        model.txPwdStatus = origModel.txPwdStatus;
                        model.loginType = origModel.loginType;
                        model.loginNum = origModel.loginNum;
                        model.userResp = input[@"data"];
                        [BaseMethod saveObject:model withKey:UserInfo_UDSKEY];
                        self.userResp = input[@"data"];
                        [subscriber sendNext:model];
                        
                        [self addGoodsToNetCart];
                    }else {
                        kShowMessage
                        [subscriber sendNext:nil];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _personDataCmd;
}


/**
 上传本地商品到购物车，登录完成后执行
 */
- (void)addGoodsToNetCart{
    
    if (![self goodsIds].length) return;
    
    [NetWorkManager.sharedManager requestWithUrl:kGod_uploadCartFromLocal withParameters:@{@"goods_id":[self goodsIds]} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        if (kStatusTrue) {
            [BaseMethod deleteObjectForKey:ZCGoodsDictionary_UDSKey];
        }else {
//            [self performSelector:@selector(addGoodsToNetCart) withObject:nil afterDelay:5];
        }
        kShowMessage;
    } withFailure:^(NSError * _Nonnull error) {
//        [self performSelector:@selector(addGoodsToNetCart) withObject:nil afterDelay:5];
        kShowError
    }];
}


/**
 本地商品id，，支持批量上传
 
 @return 拼接的上传参数
 */
- (NSString *)goodsIds {
    NSArray *tempArray = [BaseMethod shopGoodsFromeUserDefaults];
    if (!tempArray.count) return @"";
    
    NSMutableArray *mArray = [NSMutableArray array];
    [tempArray enumerateObjectsUsingBlock:^(ZCPublicGoodsModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *item = StringFormat(@"%@:%@", obj.goods_id,obj.have_num);
        [mArray addObject:item];
        
    }];
    
    return [mArray componentsJoinedByString:@","];
}



@end
