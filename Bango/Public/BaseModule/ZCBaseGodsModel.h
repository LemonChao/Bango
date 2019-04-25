//
//  ZCBaseGodsModel.h
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseGodsModel : ZCBaseModel

/** 商品在购物车中的数量 */
@property (nonatomic, copy) NSString *have_num;
/** 购物车 - 按钮是否应该隐藏 */
@property (nonatomic, assign) BOOL hide;
/** 商品id */
@property(nonatomic, copy) NSString *goods_id;

/** 数量为1 删除需要确认 */
@property(nonatomic, assign) BOOL deleteEnsure;

/** 是否拼团商品，拼团商品不能添加购物车 */
@property(nonatomic, assign) BOOL is_pin;

@end

NS_ASSUME_NONNULL_END
