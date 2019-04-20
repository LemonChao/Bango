//
//  UserInfoModel.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject

/** 加密token */
@property(nullable, nonatomic, copy) NSString *asstoken;

/** 提现密码状态 0:未设置  1:已设置 */
@property(nonatomic, copy) NSString *txPwdStatus;

/** 登陆类型 0:微信登陆  1:支付宝登陆(存在本地)  2:普通登陆 */
@property(nonatomic, copy) NSString *loginType;

/** 登陆次数 新用户次数为1, */
@property(nonatomic, copy) NSString *loginNum;

/** 头像 */
@property(nonatomic, copy) NSString *avatar;

//--------个人资料接口获取
/** 头像 推荐用这个 */
@property(nonatomic, copy) NSString *avatarhead;

/** 用户名 */
@property(nonatomic, copy) NSString *userName;

/** 用户手机号 */
@property(nonatomic, copy) NSString *userTel;

/** 是否绑定手机号 0:未绑定 1:已绑定 */
@property(nonatomic, copy) NSString *userTelIsset;

/** 昵称 */
@property(nonatomic, copy) NSString *nickName;

/**  密码设置状态 0：未设置登陆密码  1：已设置 */
@property(nonatomic, copy) NSString *userPasswordStatus;

/** 登录完成后的 userResp */
@property(nonatomic, strong) id userResp;

@end

NS_ASSUME_NONNULL_END
