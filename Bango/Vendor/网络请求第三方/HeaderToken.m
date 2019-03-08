//
//  HeaderToken.m
//
//  Created by 张海彬 on 2018/1/23.
//  Copyright © 2018年 张海彬. All rights reserved.
//
#define ACCESS_TOKEN         @"ACCESS_TOKEN"
#define EXPIRES              @"expires"

#define REFRESHTOKEN         @"RefreshToken"
#define RefreshTokenExpires         @"RefreshTokenExpires"

#import "HeaderToken.h"
#import <YYKit/YYKit.h>
static NSString *const LVNetworkHeaderToken = @"LVNetworkHeaderToken";
@implementation HeaderToken
static YYCache *_dataTokenCache;
+(void)initialize{
    _dataTokenCache = [YYCache cacheWithName:LVNetworkHeaderToken];
}
#pragma mark 存Token值
+(void)setToken:(NSString *)token{
    if (![NSString isNOTNull:token]) {
        [_dataTokenCache setObject:token forKey:ACCESS_TOKEN withBlock:nil];
    }
}
#pragma mark 取Token值
+(id)getAccessToken{
    NSString *date = [NSString stringFromDate:[NSDate date]];
    NSString *expiresDate = [HeaderToken getExpires];
    NSString *Poor  = [NSString dateTimeDifferenceWithStartTime:date endTime:expiresDate];
    if (expiresDate.length > 0) {
        int PoorDate = [Poor intValue];
        if (PoorDate < 300 && PoorDate> 0) {
            return [_dataTokenCache objectForKey:ACCESS_TOKEN];
        }else if ( PoorDate <= 0){
            return @"";
        }
        return [_dataTokenCache objectForKey:ACCESS_TOKEN];
    }else{
        return @"";
    }
    
}
#pragma mark 存RefreshToken值
+(void)setRefreshToken:(NSString *)RefreshToken{
    if (![NSString isNOTNull:RefreshToken]) {
        [_dataTokenCache setObject:RefreshToken forKey:REFRESHTOKEN withBlock:nil];
    }
}
#pragma mark 取RefreshToken值
+(id)getRefreshToken{
    NSString *date = [NSString stringFromDate:[NSDate date]];
    NSString *expiresDate = [HeaderToken getRefreshTokenExpires];
    NSString *Poor  = [NSString dateTimeDifferenceWithStartTime:date endTime:expiresDate];
    if (expiresDate.length > 0) {
        int PoorDate = [Poor intValue];
        if ( PoorDate > 0) {
            return [_dataTokenCache objectForKey:REFRESHTOKEN];
        }else{
            return @"";
        }
    }else{
        return @"";
    }
    
}
#pragma mark ======Token和RefreshToken过期时间处理=====
#pragma mark 存Token值的过期时间
+(void)setExpires:(NSString *)expires{
    //异步缓存,不会阻塞主线程
    if (![NSString isNOTNull:expires]) {
        [_dataTokenCache setObject:expires forKey:EXPIRES withBlock:nil];
    }
}
#pragma mark 获取Token值的过期时间
+(id)getExpires{
    return [_dataTokenCache objectForKey:EXPIRES];
}
#pragma mark 存RefreshToken过期时间的值
+(void)setRefreshTokenExpires:(NSString *)Expires{
    if (![NSString isNOTNull:Expires]) {
         [_dataTokenCache setObject:Expires forKey:RefreshTokenExpires withBlock:nil];
    }
}
#pragma mark 获取RefreshToken值的过期时间
+(id)getRefreshTokenExpires{
    return [_dataTokenCache objectForKey:RefreshTokenExpires];
}
#pragma mark === 删除所有网络缓存===
+ (void)removeAllHttpCache {
    [_dataTokenCache.diskCache removeAllObjects];
}
+(void)valueEmpty{
    [_dataTokenCache setObject:@"" forKey:ACCESS_TOKEN];
    [_dataTokenCache setObject:@"" forKey:EXPIRES];
    [_dataTokenCache setObject:@"" forKey:REFRESHTOKEN];
    [_dataTokenCache setObject:@"" forKey:RefreshTokenExpires];
}
@end






















