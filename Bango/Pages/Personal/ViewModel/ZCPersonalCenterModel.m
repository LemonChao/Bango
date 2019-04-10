//
//  ZCPersonalCenterModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalCenterModel.h"

@implementation ZCPersonalCenterModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"platforms":[ZCPersonalAdvModel class]};
}


@end


@implementation ZCPersonalAdvModel



@end

