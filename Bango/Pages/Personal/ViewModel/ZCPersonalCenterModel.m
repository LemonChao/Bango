//
//  ZCPersonalCenterModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalCenterModel.h"

@implementation ZCPersonalCenterModel

- (instancetype)initWithExpiration
{
    self = [super init];
    if (self) {
        self.continuous_signs = self.is_sign = self.pay_ords = self.fa_ords = self.shou_ords = self.virtual_wait_evaluate = self.refund_ords = self.tot_money = self.tui_count = self.award = self.energy = self.guo_open = @"0";
        self.nick_name = @"请点击登陆";
        self.jibie = @"普通会员";
        self.level = @"47";
        self.platforms = @[[ZCPersonalAdvModel new],[ZCPersonalAdvModel new]];
    }
    return self;
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"platforms":[ZCPersonalAdvModel class]};
}


@end


@implementation ZCPersonalAdvModel



@end

