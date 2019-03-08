//
//  CommonTools.h
//  ShanDianPaoTui
//
//  Created by 张海彬 on 2017/8/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonTools : NSObject

/**
 *  网络是否异常
 *
 *  @return yes OR no
 */
+ (BOOL)networkIsAnomaly;

/**
 *  设置网络是否异常
 *
 *  @param yesOrNo yes OR no
 */
+ (void)setNetworkIsAnomaly:(BOOL)yesOrNo;

/**
 获取有效期内的toke，当字符串长度为0时，需要重写获取

 @return
 */
+(NSString *)getAccessToken;

/**
 保存token

 @param token 值
 */
+(void)setToken:(NSString *)token;

/**
 获取toke的过期时间

 @return 返回时间
 */
+(NSString *)getExpires;

/**
 保存token过期时间

 @param expires 过期时间
 */
+(void)setExpires:(NSString *)expires;

/**
 存RefreshToken的值

 @param RefreshToken 值
 */
+(void)setRefreshToken:(NSString *)RefreshToken;


/**
 获取RefreshToken的值，当字符串长度为0时，需要重写获取

 @return 返回RefreshToken值
 */
+(NSString *)getRefreshToken;

/**
 存RefreshToken过期时间

 @param Expires RefreshToken过期时间
 */
+(void)setRefreshTokenExpires:(NSString *)Expires;

/**
 获取RefreshToken过期时间

 @return 返回过期时间
 */
+(NSString *)getRefreshTokenExpires;

/**
 *  token是否即将过期
 *
 *  @return yes OR no
 */
+ (BOOL)upcomingExpired;

/**
 *  设置token是否即将过期
 *
 *  @param yesOrNo YES即将过期，已过期 NO：未过期
 */
+ (void)setUpcomingExpired:(BOOL)yesOrNo;

/**
 存是否强制更新

 @param isForce BOOL值
 */
+(void)setIsForce:(BOOL)isForce;

/**
 返回变量

 @return BOOL值
 */
+(BOOL)IsForce;

/**
 是否有新版本

 @param HasNewVersion bool值
 */
+(void)setIsHasNewVersion:(BOOL)HasNewVersion;

/**
 返回是否有新版本

 @return  BOOL值
 */
+(BOOL)IsHasNewVersion;

/**
 存储版本信息

 @param index 
 */
+(void)setUpdateDescription:(NSString *)description;

/**
 返回版本信息

 @return
 */
+(NSString *)getUpdateDescription;

/**
 当前点击的页面

 @param index 页面值
 */
+(void)setClickView:(NSString *)index;

/**
 获取当前点击的页面

 @return
 */
+(NSString *)getClickView;

/**
 存数据库版本号

 @param Versions 版本号
 */
+(void)setDataDaseVersions:(NSString *)Versions;

/**
 获取数据库版本号

 @return
 */
+(NSString *)getDataDaseVersions;

/**
 保存活动时间请求

 @param time 时间
 */
+(void)setActivityRequestTime:(NSString *)time;

/**
 返回 活动时间请求

 @return 回调
 */
+(NSString *)getActivityRequestTime;

/**
 保存更新版本地址
 */
+(void)setUpdateVersionAddress:(NSString *)address;
/**
 获取版本地址
 */
+(NSString *)getVersionAddress;

/**
 	保存版本号
 */
+(void)setVersionString:(NSString *)version;
/**
 	获取版本号
 */
+(NSString *)getVersionString;
@end








