//
//  ZCClassifyViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/4.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyViewModel.h"

@implementation ZCClassifyViewModel

- (RACCommand *)classifyCmd {
    if (!_classifyCmd) {
        _classifyCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kAllCategory_home withParameters:@{} withRequestType:POSTTYPE responseCache:^(id  _Nonnull responseObject) {
                    
                    self.dataArray = [NSArray modelArrayWithClass:[ZCClassifyModel class] json:responseObject[@"data"]];
                    [subscriber sendNext:@(1)];
                } withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        self.dataArray = [NSArray modelArrayWithClass:[ZCClassifyModel class] json:responseObject[@"data"]];
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }

                    [subscriber sendCompleted];

                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];

                return nil;
            }] doNext:^(id  _Nullable x) {
            }];
        }];
        
        
    }
    return _classifyCmd;
}



@end
