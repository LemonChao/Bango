//
//  ZCCartModel.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartModel.h"

@implementation ZCCartModel

- (instancetype)initWithName:(NSString *)name aid:(NSString *)aid selectAll:(BOOL)select goods:(NSArray *)goods{
    self = [super init];
    if (self) {
        self.shop_id = aid;
        self.shop_name = name;
        self.selectAll = select;
        self.shop_goods = goods.mutableCopy;
    }
    return self;
}


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"shop_goods":[ZCPublicGoodsModel class]};
}

@end

//@implementation ZCCartGodsModel
//
//
//@end

