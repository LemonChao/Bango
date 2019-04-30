//
//  ZCSystemNoticeVM.m
//  Bango
//
//  Created by zchao on 2019/4/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeVM.h"
#import "NSString+Helper.h"

@implementation ZCSystemNoticeVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.readed = YES;
    }
    return self;
}


- (RACCommand *)noticeListCmd {
    if (!_noticeListCmd) {
        _noticeListCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @weakify(self);
                [NetWorkManager.sharedManager requestWithUrl:kNotice_home withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    __block BOOL hasReaded = YES;
                    if (kStatusTrue) {
                        self.dataArray = [NSArray modelArrayWithClass:[ZCSystemNoticeModel class] json:responseObject[@"data"]];
                        [self.dataArray enumerateObjectsUsingBlock:^(__kindof ZCSystemNoticeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSLog(@"%ld", idx);
                            if (!obj.is_read.integerValue) {
                                hasReaded = NO;
                                *stop = YES;
                            }
                        }];
                        
                        [subscriber sendNext:@(1)];
                    }else {
                        kShowMessage
                        [subscriber sendNext:@(0)];
                    }
                    self.readed = hasReaded;
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    kShowError
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _noticeListCmd;
}


- (RACCommand *)noticeCmd {
    if (!_noticeCmd) {
        _noticeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @weakify(self);
                [NetWorkManager.sharedManager requestWithUrl:kNotice_home withParameters:@{} withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    __block BOOL hasReaded = YES;
                    if (kStatusTrue) {
                        self.dataArray = [NSArray modelArrayWithClass:[ZCSystemNoticeModel class] json:responseObject[@"data"]];
                        
                        [self.dataArray enumerateObjectsUsingBlock:^(__kindof ZCSystemNoticeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            if (idx == 0) {
                                self.showTime = [obj.create_time timeStampStringSinceNow];
                            }
                            if (!obj.is_read.integerValue) {
                                hasReaded = NO;
                                *stop = YES;
                            }
                        }];
                        
                        [subscriber sendNext:@(hasReaded)];
                    }else {
                        [subscriber sendNext:@(hasReaded)];
                    }
                    self.readed = hasReaded;
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    [subscriber sendError:error];
                }];
                
                return nil;
            }];
        }];
    }
    return _noticeCmd;
}


@end

