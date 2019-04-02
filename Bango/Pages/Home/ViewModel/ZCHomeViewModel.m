//
//  ZCHomeViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeViewModel.h"

@implementation ZCHomeViewModel


- (RACCommand *)homeCmd {
    if (!_homeCmd) {
        @weakify(self);
        _homeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kIndex_home withParameters:@{} withRequestType:POSTTYPE responseCache:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    if (kStatusTrue) {
                        ZCHomeModel *model = [ZCHomeModel modelWithDictionary:responseObject[@"data"]];
                        self.home = model;
                        [subscriber sendNext:@(1)];
                    }
                    
                    [subscriber sendCompleted];
                    
                } withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    if (kStatusTrue) {
                        ZCHomeModel *model = [ZCHomeModel modelWithDictionary:responseObject[@"data"]];
                        self.home = model;
                        [subscriber sendNext:@(1)];
                        
                    }else {
                        [MBProgressHUD showText:responseObject[@"message"]];
                        [subscriber sendNext:@(0)];
                    }
                    
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [MBProgressHUD showText:error.localizedDescription];
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
            
            
        }];
    }
    return _homeCmd;
}




@end
