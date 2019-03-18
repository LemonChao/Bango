//
//  ShareDelegateManager.h
//  Bango
//
//  Created by zchao on 2019/3/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareDelegateManager : NSObject

+ (instancetype)shareDelegateManager;

- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions withWindow:(UIWindow *)window;

- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;


@end

NS_ASSUME_NONNULL_END
