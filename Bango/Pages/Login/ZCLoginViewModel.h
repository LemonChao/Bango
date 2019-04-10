//
//  ZCLoginViewModel.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCLoginViewModel : ZCBaseViewModel

/** 获取验证码 */
@property(nonatomic, strong) RACCommand *authCodeCmd;

/** 手机号登陆 */
@property(nonatomic, strong) RACCommand *phoneCmd;

/** 支付宝登陆Cmd */
@property(nonatomic, strong) RACCommand *zhifubaoCmd;

/** 微信登陆Cmd */
@property(nonatomic, strong) RACCommand *wechatCmd;

/** 用户个人资料 */
@property(nonatomic, strong) RACCommand *personDataCmd;

/** 验证码 */
@property(nonatomic, copy) NSString *authCodeString;

/** 登录手机号 */
@property(nonatomic, copy) NSString *phoneNumber;


/** 推荐的登录方式 0:微信登陆  1:支付宝登陆(存在本地)  2:普通登陆 */
@property(nonatomic, copy) NSString *loginType;

@property(nonatomic, copy) NSString *loginBtnTitle;

@end

NS_ASSUME_NONNULL_END
