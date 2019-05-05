//
//  UpdataViewModel.m
//  Bango
//
//  Created by zchao on 2019/4/22.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UpdataViewModel.h"
#import "SELUpdateAlert.h"

@interface UpdataViewModel ()

@property(nonatomic, strong) SELUpdateAlert *alert;

@end

@implementation UpdataViewModel

- (RACCommand *)updateCmd {
    if (!_updateCmd) {
        @weakify(self);
        _updateCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSDictionary *_Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [NetWorkManager.sharedManager requestWithUrl:kIndex_version withParameters:@{@"appname":@"搬果将",@"type":@"2",@"version":AppVersion} withRequestType:POSTTYPE responseCache:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    self.model = [ZCUpdateModel modelWithDictionary:responseObject[@"data"]];
                } withSuccess:^(id  _Nonnull responseObject) {
                    @strongify(self);
                    ZCUpdateModel *model = [ZCUpdateModel modelWithDictionary:responseObject[@"data"]];
                    if (kStatusTrue) {
                        [self versionBouncedWithModel:model];
                    }
                    [subscriber sendNext:@(1)];
                    [subscriber sendCompleted];
                } withFailure:^(NSError * _Nonnull error) {
                    @strongify(self);
                    ZCUpdateModel *model = self.model.copy;
                    
                    [self versionBouncedWithModel:model];
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _updateCmd;
}


- (void)versionBouncedWithModel:(ZCUpdateModel *)model {
    
    if (![model.is_update boolValue]) return;//不需要提示版本更新

    [self.alert removeFromSuperview];
    
    self.alert = [SELUpdateAlert showUpdateAlertWithVersion:model.ver_nod Description:model.remark];
    self.alert.isMandatory = model.force_update.boolValue;
    self.alert.updateNow = ^{
        if (StringIsEmpty(model.url)) {
            [MBProgressHUD showText:@"更新地址错误"];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
        }
    };
}


@end

@implementation ZCUpdateModel

- (id)copyWithZone:(NSZone *)zone {
    // 如果子类覆写该方法, 则[self class]的类型为子类型，如果直接使用
    // [[SubClass allocWithZone:zone] init]， 则子类覆写时会出错.
    ZCUpdateModel *model = [[[self class] allocWithZone:zone] init];
    model.aid = self.aid;
    model.name = self.name;
    model.ver_no = self.ver_no;
    model.ver_nod = self.ver_nod;
    model.type = self.type;
    model.url = self.url;
    model.force_update = self.force_update;
    model.remark = self.remark;
    model.createdate = self.createdate;
    model.edit_time = self.edit_time;
    model.is_update = self.is_update;
    
    return model;
}

@end


