//
//  InterfaceHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h

#define kOnLine   0
#if kOnLine
//生产环境
#define AppBaseUrl                              @"https://mr-bango.cn/"
#define AppPictureBaseUrl                       @"https://appapi.toushijinfu.com/"
#define AppKeChengBaseUrl                       @"http://kecheng.toushijinfu.com/"
#else
//测试环境
#define AppBaseUrl                              @"https://mr-bango.cn/"
#define AppPictureBaseUrl                       @"http://admin1.toushizhiku.com/"
#define AppKeChengBaseUrl                       @"http://oa.mgogo.com/kecheng/"
#endif



#pragma mark - 登陆注册

// 获取验证码
#define kLogin_sendcode         @"?s=/wap/login/sendCode"
// 手机号登陆
#define kLogin_index            @"?s=/wap/login/index"
// 支付宝加密字符串(内含authCode)
#define kLogin_alipay           @"?s=/wap/Login/alipay_Login"
// 支付宝用户信息(拿authCode换取token以及用户信息)
#define kLogin_alipay_auth      @"?s=/wap/Login/get_auth_code"
// 第三方登陆(微信，支付宝)
#define kLogin_third            @"?s=/wap/Login/wc_alipay_Login"


#endif /* InterfaceHeader_h */
