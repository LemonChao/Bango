//
//  ZCCartViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartViewModel.h"

@implementation ZCCartViewModel

- (RACCommand *)emptyCartCmd {
    if (!_emptyCartCmd) {
        _emptyCartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                
                [NetWorkManager.sharedManager requestWithUrl:kChart_like withParameters:@{@"asstoken":info.asstoken} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
                        NSDictionary *dic = responseObject[@"data"];
                        self.dataArray = [NSArray modelArrayWithClass:[ZCCartTuijianModel class] json:dic[@"tuijian"]];
                        
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage;
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError;
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _emptyCartCmd;
}


@end
