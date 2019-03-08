//
//  WB_BatchRequest.m
//  GDP
//
//  Created by 张海彬 on 2018/8/15.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "WB_BatchRequest.h"

@implementation WB_BatchRequest
- (void)startWithoutCacheCompletionBlockWithSuccess:(void (^)(YTKBatchRequest *batchRequest))success
                                            failure:(void (^)(YTKBatchRequest *batchRequest))failure{
     [self setCompletionBlockWithSuccess:success failure:failure];
     [self startWithoutCache];
}

@end
