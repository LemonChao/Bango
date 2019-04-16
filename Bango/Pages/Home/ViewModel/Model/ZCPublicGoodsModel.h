//
//  ZCPublicGoodsModel.h
//  Bango
//
//  Created by zchao on 2019/4/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseGodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCPublicGoodsModel : ZCBaseGodsModel
//水果专区 干果专区... 商品model

//@property(nonatomic, copy) NSString *goods_id;
//@property(nonatomic, copy) NSString *goods_name;
//@property(nonatomic, copy) NSString *introduction;
//@property(nonatomic, copy) NSString *is_hot;
//@property(nonatomic, copy) NSString *is_new;
//@property(nonatomic, copy) NSString *is_recommend;
//@property(nonatomic, copy) NSString *market_price;
//@property(nonatomic, copy) NSString *pic_cover_small;
@property(nonatomic, copy) NSString *colonel_content;
@property(nonatomic, copy) NSString *point_exchange;
@property(nonatomic, copy) NSString *point_exchange_type;
//@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *shipping_fee;
//@property(nonatomic, copy) NSString *state;


//购物车 商品model
/** 购物车id */
@property(nonatomic, copy) NSString *cart_id;
/** 用户id */
@property(nonatomic, copy) NSString *buyer_id;
/** 商铺名称 */
@property(nonatomic, copy) NSString *shop_name;
///** 商品id */ base里面有该属性
//@property(nonatomic, copy) NSString *goods_id;
/** 商品名称 */
@property(nonatomic, copy) NSString *goods_name;
/** 商品介绍 */
@property(nonatomic, copy) NSString *introduction;
/** 商品库存 */
@property(nonatomic, copy) NSString *stock;
/** 商品状态  0下架，1正常，10违规（禁售） */
@property(nonatomic, copy) NSString *state;
/** 最大购买：限购 0 不限购   */
@property(nonatomic, copy) NSString *max_buy;
/** 最少购买：限购 0 不限购   */
@property(nonatomic, copy) NSString *min_buy;
/** //商品促销价格 */
@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *pic_cover_big;
@property(nonatomic, copy) NSString *pic_cover_mid;

@property(nonatomic, assign, getter=isSelected) BOOL selected;
/** 商品标签 */
@property(nonatomic, copy) NSArray *tagArray;

//推荐商品model
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *goods_type;
@property(nonatomic, copy) NSString *pic_id;
@property(nonatomic, copy) NSString *is_hot;
@property(nonatomic, copy) NSString *is_recommend;
@property(nonatomic, copy) NSString *is_new;
@property(nonatomic, copy) NSString *sales;
@property(nonatomic, copy) NSString *pic_cover_small;


@end

NS_ASSUME_NONNULL_END
