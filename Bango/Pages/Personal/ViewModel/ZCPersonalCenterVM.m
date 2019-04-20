//
//  ZCPersonalCenterVM.m
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalCenterVM.h"

@implementation ZCPersonalCenterVM

- (RACCommand *)memberCmd {
    if (!_memberCmd) {
        @weakify(self);
        _memberCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSString  *_Nonnull input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kMember_index withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    if (kStatusTrue) {
                        self.model = [ZCPersonalCenterModel modelWithDictionary:responseObject[@"data"]];
                        
                        [subscriber sendNext:@(1)];
                    }else if ([responseObject[@"status"] integerValue] == -1){//过期
                        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
                        info.asstoken = nil;
                        [BaseMethod saveObject:info withKey:UserInfo_UDSKEY];
                        self.model = [[ZCPersonalCenterModel alloc] initWithExpiration];
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
    return _memberCmd;
}



@end
