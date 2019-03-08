//
//  WB_BatchRequest.h
//  GDP
//
//  Created by 张海彬 on 2018/8/15.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "YTKBatchRequest.h"

@interface WB_BatchRequest : YTKBatchRequest
/**
 清除缓存请求数据
 
 @param success 成功回调
 @param failure 失败回调
 */
- (void)startWithoutCacheCompletionBlockWithSuccess:(void (^)(YTKBatchRequest *batchRequest))success
                                            failure:(void (^)(YTKBatchRequest *batchRequest))failure;
@end
