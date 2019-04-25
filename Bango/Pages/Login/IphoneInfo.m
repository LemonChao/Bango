//
//  IphoneInfo.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "IphoneInfo.h"

@implementation IphoneInfo

+ (instancetype)sharedIphoneInfo {
    static IphoneInfo *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [BaseMethod readObjectWithKey:IphoneInfoModel_UDSKEY];
        if (!info) {
            info = [[IphoneInfo alloc] init];
            [info setupIphoneInfo];
        }
    });
    return info;
}



- (void)setupIphoneInfo {
    
    self.systemVersion = [[UIDevice currentDevice] systemVersion];
    self.appVersion = AppVersion;
    self.uuid = @"uuid";
    self.channel = @"AppStore";
    self.net = @"wifi";
    self.iphone = @"iPhone";
    if ([[NSUserDefaults standardUserDefaults] boolForKey:showGuidePageKey]) {//已安装
        self.firstInstall = @0;
        
    }else {//首次安装
        NSString *timeStamp = [NSString stringWithFormat:@"%0.f", [[NSDate date] timeIntervalSince1970]];
        self.firstInstall = @1;
        self.installtime = timeStamp;
    }

    
    [BaseMethod saveObject:self withKey:IphoneInfoModel_UDSKEY];
}


- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _systemVersion = [coder decodeObjectForKey:@"systemVersion"];
        _appVersion = [coder decodeObjectForKey:@"appVersion"];
        _uuid = [coder decodeObjectForKey:@"uuid"];
        _channel = [coder decodeObjectForKey:@"channel"];
        _net = [coder decodeObjectForKey:@"net"];
        _iphone = [coder decodeObjectForKey:@"iphone"];
        _installtime = [coder decodeObjectForKey:@"installtime"];
        _firstInstall = [coder decodeObjectForKey:@"firstInstall"];
        _appVerFirstLaunch = [coder decodeObjectForKey:@"appVerFirstLaunch"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.systemVersion != nil) [coder encodeObject:self.systemVersion forKey:@"systemVersion"];
    if (self.appVersion != nil) [coder encodeObject:self.appVersion forKey:@"appVersion"];
    if (self.uuid != nil) [coder encodeObject:self.uuid forKey:@"uuid"];
    if (self.channel != nil) [coder encodeObject:self.channel forKey:@"channel"];
    if (self.net != nil) [coder encodeObject:self.net forKey:@"net"];
    if (self.iphone != nil) [coder encodeObject:self.iphone forKey:@"iphone"];
    if (self.installtime != nil) [coder encodeObject:self.installtime forKey:@"installtime"];
    if (self.firstInstall != nil) [coder encodeObject:self.firstInstall forKey:@"firstInstall"];
    if (self.appVerFirstLaunch != nil) [coder encodeObject:self.appVerFirstLaunch forKey:@"appVerFirstLaunch"];
}




@end
