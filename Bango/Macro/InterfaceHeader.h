//
//  InterfaceHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h

#define kOnLine   1
#if kOnLine
//生产环境
#define AppBaseUrl                              @"http://www.lsqxsc.com/"
#define AppPictureBaseUrl                       @"https://appapi.toushijinfu.com/"
#define AppGuoGuoBaseUrl                        @"https://mr-bango.cn/GuoGuoGame/"
#else
//测试环境
#define AppBaseUrl                              @"http://ceshi.mr-bango.cn/"
#define AppPictureBaseUrl                       @"http://admin1.toushizhiku.com/"
#define AppGuoGuoBaseUrl                        @"http://ceshi.mr-bango.cn/GuoGuoGame/"
#endif

#define AppIconUrl                              @"https://www.lsqxsc.com/template/wap/default_new/public/css/qianrui/images/logo.png"

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
// 获取用户个人资料
#define kMember_personData      @"?s=/wap/Member/personalData"
// 微信支付
#define kOrderinfo_weixinpay    @"?s=/wap/paywx/wx_pay"
// 支付宝支付
#define kOrderinfo_alipay       @"?s=/wap/paywx/order_info_alipay"
// app版本更新
#define kIndex_version          @"?s=/wap/Index/version"
// 首页
#define kIndex_home             @"?s=/wap/Index/app_index"
// 分类首页
#define kAllCategory_home       @"?s=/wap/Goods/goodsAllCategoryListAPPJin"
// 公告列表-首页
#define kNotice_home            @"?s=/wap/notice/getNotice"
//会员中心
#define kMember_index           @"?s=/wap/Member/memberIndex"
//购物车-猜你喜欢
#define kChart_like             @"?s=/wap/Goods/cart_app_wj"
//商品-添加购物车
#define kGods_addCart           @"?s=/wap/Goods/addCar"
//商品-从购物车删除
#define kGods_deleteCart        @"?s=/wap/Goods/cartDelete"
//商品-修改商品在购物车数量
#define kGods_cartAdjustNum     @"?s=/wap/Goods/cartAdjustNum_app"
//购物车-删除商品 多商品逗号拼接cart_id "4,5"
#define kGods_cartDelete        @"?s=/wap/Goods/cartDelete"
//添加到购物车，支持批量 (本地保存的商品上传)
#define kGod_uploadCartFromLocal   @"?s=/wap/Goods/addCart_more"

//会员中心分享好友
#define kshareAppToFriend       @"?s=/wap/share/shareFriend"

#endif /* InterfaceHeader_h */
