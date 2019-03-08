//
//  HeaderToken.h
//
//  Created by 张海彬 on 2018/1/23.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderToken : NSObject
/**存Token值 (token:请求来的token值)*/
+(void)setToken:(NSString *)token;

/** 取Token值(字符串为nil时说明token过期了)*/
+(NSString *)getAccessToken;

/** 存RefreshToken值 (RefreshToken:请求来的RefreshToken值)*/
+(void)setRefreshToken:(NSString *)RefreshToken;

/** 取RefreshToken值(字符串为nil时说明RefreshToken过期了)*/
+(NSString *)getRefreshToken;

/** 存Token值的过期时间 (expires:请求来的Token的过期时间)*/
+(void)setExpires:(NSString *)expires;

/** 存RefreshToken值  (Expires:请求来的RefreshToken的过期时间)*/
+(void)setRefreshTokenExpires:(NSString *)Expires;

/// 删除所有网络缓存
+ (void)removeAllHttpCache;
/// 所有值置空
+(void)valueEmpty;
@end


























