//
//  ZCLoginViewModel.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCLoginViewModel.h"

@implementation ZCLoginViewModel

- (RACCommand *)authCodeCmd {
    if (!_authCodeCmd) {
        @weakify(self);
        _authCodeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kLogin_sendcode withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    self.authCodeString = @"";
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _authCodeCmd;
}


- (RACCommand *)loginCmd {
    if (!_loginCmd) {
        _loginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary  *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kLogin_index withParameters:input withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _loginCmd;
}



@end
