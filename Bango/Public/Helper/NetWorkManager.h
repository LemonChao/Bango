//
//  NetWorkManager.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

/* NetWorkType */
typedef enum : NSUInteger {
    GETTYPE = 0,
    POSTTYPE,
    PUTTYPE,
    DELETETYPE,
} NetWorkType;

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestWithUrl:(NSString *)url withParameters:(NSDictionary *)params withRequestType:(NetWorkType)requestType withSuccess:(void (^)(id responseObject))success withFailure:(void (^)(NSError *error))failure;

/** 自动缓存，成功后更新 */
- (void)requestWithUrl:(NSString *)url withParameters:(NSDictionary *)params withRequestType:(NetWorkType)requestType responseCache:(void (^)(id responseObject))caches withSuccess:(void (^)(id responseObject))success withFailure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
