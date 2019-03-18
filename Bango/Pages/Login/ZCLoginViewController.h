//
//  ZCLoginViewController.h
//  Bango
//
//  Created by zchao on 2019/3/14.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCLoginViewController : ZCBaseViewController


/** 登录结果回调*/
@property (nonatomic,copy) void (^loginCallback)(NSDictionary *userInfo);

@end

NS_ASSUME_NONNULL_END
