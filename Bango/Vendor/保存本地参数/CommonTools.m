    //
    //  CommonTools.m
    //  ShanDianPaoTui
    //
    //  Created by 张海彬 on 2017/8/12.
    //  Copyright © 2017年 mac. All rights reserved.
    //
#import "NSString+Helper.h"
#import "CommonTools.h"
#define NETWORK_IS_ANOMALY   @"kNetworkIsAnomaly"
#define ACCESS_TOKEN         @"ACCESS_TOKEN"
#define EXPIRES              @"expires"
#define REFRESHTOKEN         @"RefreshToken"
#define REFRESHTOKENEXPIRES  @"RefreshTokenExpires"
#define UpcomingExpired      @"upcomingExpired"
#define ISFORCE              @"isForce"
#define ISHASNEWVERSION      @"IsHasNewVersion"
#define ClickView            @"ClickView"
#define UpdateDescription    @"UpdateDescription"
#define VERSIONS             @"Versions"
#define ActivityRequestTim   @"ActivityRequestTim"
#define VersionAddress        @"VersionAddress"
#define VersionString        @"VersionString"
@implementation CommonTools

+ (void)setNetworkIsAnomaly:(BOOL)yesOrNo;
{
    [[NSUserDefaults standardUserDefaults] setBool:yesOrNo forKey:NETWORK_IS_ANOMALY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)networkIsAnomaly;
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:NETWORK_IS_ANOMALY];
}
#pragma mark ===存Token值====
+(void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:ACCESS_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ===取Token值====
+(NSString *)getAccessToken{
    NSString *date = [NSString stringFromDate:[NSDate date]];
    NSString *expiresDate = [CommonTools getExpires];
    NSString *Poor  = [NSString dateTimeDifferenceWithStartTime:date endTime:expiresDate];
    
    if (expiresDate.length > 0) {
        int PoorDate = [Poor intValue];
        if (PoorDate < 300 && PoorDate> 0) {
            [CommonTools setUpcomingExpired:YES];
            return [[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN];
        }else if ( PoorDate <= 0){
            [CommonTools setUpcomingExpired:YES];
            return @"";
        }
        [CommonTools setUpcomingExpired:NO];
        NSLog(@"[[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN] = %@",[[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN]);
        return [[NSUserDefaults standardUserDefaults] stringForKey:ACCESS_TOKEN];
    }else{
        [CommonTools setUpcomingExpired:YES];
        return @"";
    }
    
}
#pragma mark ===存Token值的过期时间====
+(void)setExpires:(NSString *)expires{
    [[NSUserDefaults standardUserDefaults]setObject:expires forKey:EXPIRES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ===获取Token值的过期时间====
+(NSString *)getExpires{
    return [[NSUserDefaults standardUserDefaults] stringForKey:EXPIRES];
}
#pragma mark ===存RefreshToken值====
+(void)setRefreshToken:(NSString *)RefreshToken{
    [[NSUserDefaults standardUserDefaults]setObject:RefreshToken forKey:REFRESHTOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ===取RefreshToken值====
+(NSString *)getRefreshToken{
    
    NSString *date = [NSString stringFromDate:[NSDate date]];
    NSString *expiresDate = [CommonTools getRefreshTokenExpires];
    NSString *Poor  = [NSString dateTimeDifferenceWithStartTime:date endTime:expiresDate];
    if (expiresDate.length > 0) {
        int PoorDate = [Poor intValue];
        if ( PoorDate > 0) {
            NSLog(@"[[NSUserDefaults standardUserDefaults] stringForKey:REFRESHTOKEN] = %@",[[NSUserDefaults standardUserDefaults] stringForKey:REFRESHTOKEN]);
            return [[NSUserDefaults standardUserDefaults] stringForKey:REFRESHTOKEN];
        }else{
            return @"";
        }
        return [[NSUserDefaults standardUserDefaults] stringForKey:REFRESHTOKEN];
    }else{
        return @"";
    }
    
}
#pragma mark ===存RefreshToken值的过期时间====
+(void)setRefreshTokenExpires:(NSString *)Expires{
    [[NSUserDefaults standardUserDefaults]setObject:Expires forKey:REFRESHTOKENEXPIRES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ===获取RefreshToken值的过期时间====
+(NSString *)getRefreshTokenExpires{
    return [[NSUserDefaults standardUserDefaults] stringForKey:REFRESHTOKENEXPIRES];
}
#pragma mark ===Toke是否即将过期====
+(BOOL)upcomingExpired{
    return [[NSUserDefaults standardUserDefaults] boolForKey:UpcomingExpired];
}
#pragma mark ===存Toke是否即将过期====
+ (void)setUpcomingExpired:(BOOL)yesOrNo{
    [[NSUserDefaults standardUserDefaults] setBool:yesOrNo forKey:UpcomingExpired];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark ===存isForce（是否强制更新）====
+(void)setIsForce:(BOOL)isForce{
    [[NSUserDefaults standardUserDefaults] setBool:isForce forKey:ISFORCE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)IsForce{
    return [[NSUserDefaults standardUserDefaults] boolForKey:ISFORCE];
}
#pragma mark ===存isForce（是否有新版本）===
+(void)setIsHasNewVersion:(BOOL)HasNewVersion{
    [[NSUserDefaults standardUserDefaults] setBool:HasNewVersion forKey:ISHASNEWVERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)IsHasNewVersion{
    return [[NSUserDefaults standardUserDefaults] boolForKey:ISHASNEWVERSION];
}
+(void)setUpdateDescription:(NSString *)description{
    [[NSUserDefaults standardUserDefaults]setObject:description forKey:UpdateDescription];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getUpdateDescription{
    return [[NSUserDefaults standardUserDefaults] stringForKey:UpdateDescription];
}
#pragma mark ===点击的哪个页面===
+(void)setClickView:(NSString *)index{
    [[NSUserDefaults standardUserDefaults]setObject:index forKey:ClickView];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getClickView{
    return [[NSUserDefaults standardUserDefaults] stringForKey:ClickView];
}
#pragma mark ===数据库版本号===
+(void)setDataDaseVersions:(NSString *)Versions{
    [[NSUserDefaults standardUserDefaults]setObject:Versions forKey:VERSIONS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getDataDaseVersions{
    return [[NSUserDefaults standardUserDefaults] stringForKey:VERSIONS];
}
#pragma mark  ====活动详情请求时间=====
+(void)setActivityRequestTime:(NSString *)time{
    [[NSUserDefaults standardUserDefaults]setObject:time forKey:ActivityRequestTim];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getActivityRequestTime{
    return [[NSUserDefaults standardUserDefaults] stringForKey:ActivityRequestTim];
}
#pragma mark  ====保存版本地址=====
+(void)setUpdateVersionAddress:(NSString *)address{
    [[NSUserDefaults standardUserDefaults]setObject:address forKey:VersionAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getVersionAddress{
    NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:VersionAddress];
    if ([str hasPrefix:@"https://"] || [str hasPrefix:@"http://"]) {
        return str;
    }else{
        return @"";
    }

}

+(void)setVersionString:(NSString *)version{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:VersionString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getVersionString{
    return [[NSUserDefaults standardUserDefaults] stringForKey:VersionString];
}
@end















