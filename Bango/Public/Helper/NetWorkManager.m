//
//  NetWorkManager.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "NetWorkManager.h"
#import "ZCNetworkCache.h"

@implementation NetWorkManager

+ (instancetype)sharedManager
{
    static NetWorkManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:AppBaseUrl]];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.removesKeysWithNullValues = YES;
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        _manager.responseSerializer = responseSerializer;
        _manager.requestSerializer.timeoutInterval = 60.f;
        _manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return _manager;
}

#pragma mark - method
- (void)requestWithUrl:(NSString *)url withParameters:(NSDictionary *)params withRequestType:(NetWorkType)requestType withSuccess:(void (^)(id responseObject))success withFailure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameter = params.mutableCopy;
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    
    if (![params containsObjectForKey:@"asstoken"]) {
        [parameter setObject:info.asstoken?:@"" forKey:@"asstoken"];
    }
    
    
    
//    if ([url containsString:kInterface]) {
//        parameter = [NSMutableDictionary dictionaryWithDictionary:params];
//        [parameter setValue:BBUserDefault.token ? BBUserDefault.token : @"" forKey:@"token"];
//        [parameter setValue:[FCUUID uuidForDevice] forKey:@"model"];
//    } else {
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
//        [dic setValue:BBUserDefault.token ? BBUserDefault.token : @"" forKey:@"token"];
//        [dic setValue:[FCUUID uuidForDevice] forKey:@"model"];
//        [parameter setValue:aesEncryptString([dic jsonStringEncoded], @"09a7614dba5cd876") forKey:@"param"];
//    }
    NSLog(@"URL:%@%@-->parameter:%@",AppBaseUrl,url, parameter);
    switch (requestType) {
        case GETTYPE:
        {
            [self GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case POSTTYPE:
        {
            [self POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case PUTTYPE:
        {
            [self PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case DELETETYPE:
        {
            [self DELETE:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }
}

//自动缓存，成功后更新
- (void)requestWithUrl:(NSString *)url withParameters:(NSDictionary *)params withRequestType:(NetWorkType)requestType responseCache:(void (^)(id responseObject))caches withSuccess:(void (^)(id responseObject))success withFailure:(void (^)(NSError *error))failure
{
    
    NSMutableDictionary *parameter = params.mutableCopy;
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    
    if (![params containsObjectForKey:@"asstoken"]) {
        [parameter setObject:info.asstoken?:@"" forKey:@"asstoken"];
    }

    //读取缓存
    id obj = [ZCNetworkCache httpCacheForURL:url parameters:parameter];
    if (caches && obj) {
        caches(obj);
    }

    NSLog(@"URL:%@-->parameter:%@",url, parameter);
    switch (requestType) {
        case GETTYPE:
        {
            [self GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                    //对数据进行异步缓存
                    if (kStatusTrue && caches) {
                        [ZCNetworkCache setHttpCache:responseObject URL:url parameters:parameter];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case POSTTYPE:
        {
            [self POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                    //对数据进行异步缓存
                    if (kStatusTrue && caches) {
                        [ZCNetworkCache setHttpCache:responseObject URL:url parameters:parameter];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case PUTTYPE:
        {
            [self PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                    //对数据进行异步缓存
                    if (kStatusTrue && caches) {
                        [ZCNetworkCache setHttpCache:responseObject URL:url parameters:parameter];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case DELETETYPE:
        {
            [self DELETE:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                if (success) {
                    success(responseObject);
                    //对数据进行异步缓存
                    if (kStatusTrue && caches) {
                        [ZCNetworkCache setHttpCache:responseObject URL:url parameters:parameter];
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        default:
            break;
    }

}



@end
