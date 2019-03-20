//
//  ShareObject.h
//  Bango
//
//  Created by zchao on 2019/3/16.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareObject : NSObject

@property(nonatomic, copy) NSDictionary *appShareInfo;

+ (ShareObject *)sharedObject;


/** app推广分享，个人中心分享 */
- (void)appShareWithParams:(NSDictionary *)params;

/** 拼团分享 */
- (void)groupShareWithText:(NSString *)text images:(id)images url:(NSURL *)url title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
