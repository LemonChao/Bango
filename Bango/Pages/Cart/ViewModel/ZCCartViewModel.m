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
                        self.tuijianDatas = [NSArray modelArrayWithClass:[ZCCartTuijianModel class] json:dic[@"tuijian"]];
                        
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


- (RACCommand *)netCartCmd {
    if (!_netCartCmd) {
        _netCartCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                
                [NetWorkManager.sharedManager requestWithUrl:kChart_like withParameters:@{@"asstoken":info.asstoken?:@""} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    if (kStatusTrue) {
//                        NSDictionary *dic = responseObject[@"data"];
//
//                        NSArray *youxiaoArray = [NSArray modelArrayWithClass:[ZCCartModel class] json:dic[@"youxiao"]];
//                        NSArray *shixiaoArray = [NSArray modelArrayWithClass:[ZCCartGodsModel class] json:dic[@"wuxiao"]];
//                        NSArray *tuijianArray = [NSArray modelArrayWithClass:[ZCCartGodsModel class] json:dic[@"tuijian"]];
//
//                        NSMutableArray *tempArray = [NSMutableArray array];
                        
                        
                        self.cartDatas = [NSArray modelArrayWithClass:[ZCCartModel class] json:responseObject[@"data"]];
                        
                        
                        
                        [self.cartDatas enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull cartModel, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([cartModel.shop_name isEqualToString:@"推荐商品"]) {
                                self.onlyTuijian = self.cartDatas.count==1;
                            }
                        }];
                        
                        
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
    return _netCartCmd;
}


@end
