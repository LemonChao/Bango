//
//  ZCCartModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartModel.h"

@implementation ZCCartModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"shop_goods":[ZCCartGodsModel class]};
}

@end

@implementation ZCCartGodsModel


@end

