//
//  IphoneInfo.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IphoneInfo : NSObject

/** 手机系统版本号 */
@property (nonatomic, copy) NSString *systemVersion;
/** app版本号 */
@property (nonatomic, copy) NSString *appVersion;
/** 唯一标示 UUID + keychain */
@property (nonatomic, copy) NSString *uuid;
/** app来源渠道 AppStore */
@property (nonatomic, copy) NSString *channel;
/** 网络类型 */
@property (nonatomic, copy) NSString *net;
/** 手机型号 */
@property (nonatomic, copy) NSString *iphone;
/** app新版本安装时间 */
@property (nonatomic, copy) NSString *installtime;
/** app首次安装 */
@property (nonatomic, strong) NSNumber *firstInstall;
/** app新版本首次启动 */
@property (nonatomic, strong) NSNumber *appVerFirstLaunch;

- (void)setupIphoneInfo;

+ (instancetype)sharedIphoneInfo;

@end

NS_ASSUME_NONNULL_END
