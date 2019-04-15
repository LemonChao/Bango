//
//  ZCCartManager.h
//  Bango
//
//  Created by zchao on 2019/4/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCCartManager : NSObject

/** 标识购物车是否有变化 */
@property(atomic, strong) NSString *change;

/** 购物车商品 key:goods_id value:GoodsModel */
@property(nonatomic, strong) NSMutableDictionary *goodsDic;

+ (instancetype)manager;

@end

NS_ASSUME_NONNULL_END
