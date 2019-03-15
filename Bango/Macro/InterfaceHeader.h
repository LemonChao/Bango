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
#define kLogin_sendcode     @"?s=/wap/login/sendCode"

// 登陆
#define kLogin_index     @"?s=/wap/login/index"


#endif /* InterfaceHeader_h */
