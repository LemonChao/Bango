//
//  ZCHomeModel.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeModel.h"

@implementation ZCHomeModel


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryList":@"good_category_logo",
             @"noticeList":@"notice",
             @"tuijianList":@"tuijian_goods_list",
             @"pintuanList":@"pintuan_goods_list",
             @"everyGods":@"category_everygod_list",
             @"bango":@"category_banguo_list"
            };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"categoryList":[ZCHomeCategoryModel class],
             @"tuijianList":[ZCHomeTuijianModel class],
             @"pintuanList":[ZCHomePintuanModel class],
             @"everyGods":[ZCHomeEverygodsModel class],
             @"noticeList":[ZCHomeNoticeModel class],
             @"lunbo":[ZCHomeAdvModel class]
             };
}




@end


@implementation ZCHomeAdvModel



@end


@implementation ZCHomeCategoryModel



@end


@implementation ZCHomeNoticeModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"notice_id":@"id"};
}

@end


@implementation ZCHomeTuijianModel



@end


@implementation ZCHomePintuanModel



@end

//@implementation ZCHomeGodsModel
//
//
//
//@end


@implementation ZCHomeEverygodsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_list":[ZCPublicGoodsModel class]};
}


@end


