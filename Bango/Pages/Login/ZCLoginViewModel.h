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

/** 登陆 */
@property(nonatomic, strong) RACCommand *loginCmd;

/** 验证码 */
@property(nonatomic, copy) NSString *authCodeString;



@end

NS_ASSUME_NONNULL_END
