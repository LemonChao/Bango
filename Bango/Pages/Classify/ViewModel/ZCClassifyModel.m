//
//  ZCClassifyModel.m
//  Bango
//
//  Created by zchao on 2019/4/4.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyModel.h"

@implementation ZCClassifyModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"good_list":[ZCPublicGoodsModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"good_list":@"good_detail"};
}

@end

@implementation ZCClassifyGodsModel


@end
