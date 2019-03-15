//
//  AppDelegateManager.h
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegateManager : NSObject

/** 判断是否是从杀死状态进入APP  */
@property (nonatomic, assign) BOOL isKillStatus;

+ (instancetype)sharedAppDelegateManager;

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window;


@end

NS_ASSUME_NONNULL_END
