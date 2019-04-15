//
//  ZCCartModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

//@interface ZCCartGodsModel : ZCBaseGodsModel
//
////"cart_id": 1146,
////"buyer_id": 862,
////"shop_name": "搬果将",
////"goods_id": 99,
////"goods_name": "四川春见耙耙柑新鲜当季水果8斤包邮中小果20~24个装",
////"introduction": "丑萌耙耙柑 多汁又美味",
////"num": 4,
////"stock": 998,
////"state": 1,
////"max_buy": 0,
////"min_buy": 0,
////"promotion_price": 70,
////"pic_cover_big": "http://ceshi.mr-bango.cn/upload/goods/20190102/e7b93218bc55fd7d647c00c59940f4551.jpg",
////"pic_cover_mid": "http://ceshi.mr-bango.cn/upload/goods/20190102/e7b93218bc55fd7d647c00c59940f4552.jpg",
//
///** 购物车id */
//@property(nonatomic, copy) NSString *cart_id;
///** 用户id */
//@property(nonatomic, copy) NSString *buyer_id;
///** 商铺名称 */
//@property(nonatomic, copy) NSString *shop_name;
/////** 商品id */ base里面有该属性
////@property(nonatomic, copy) NSString *goods_id;
///** 商品名称 */
//@property(nonatomic, copy) NSString *goods_name;
///** 商品介绍 */
//@property(nonatomic, copy) NSString *introduction;
///** 商品库存 */
//@property(nonatomic, copy) NSString *stock;
///** 商品状态  0下架，1正常，10违规（禁售） */
//@property(nonatomic, copy) NSString *state;
///** 最大购买：限购 0 不限购   */
//@property(nonatomic, copy) NSString *max_buy;
///** 最少购买：限购 0 不限购   */
//@property(nonatomic, copy) NSString *min_buy;
///** //商品促销价格 */
//@property(nonatomic, copy) NSString *promotion_price;
//@property(nonatomic, copy) NSString *pic_cover_big;
//@property(nonatomic, copy) NSString *pic_cover_mid;
//
//
////推荐商品model
//@property(nonatomic, copy) NSString *market_price;
//@property(nonatomic, copy) NSString *goods_type;
//@property(nonatomic, copy) NSString *pic_id;
//@property(nonatomic, copy) NSString *is_hot;
//@property(nonatomic, copy) NSString *is_recommend;
//@property(nonatomic, copy) NSString *is_new;
//@property(nonatomic, copy) NSString *sales;
//@property(nonatomic, copy) NSString *pic_cover_small;
//@end

@interface ZCCartModel : ZCBaseGodsModel

/** 店铺名称 */
@property(nonatomic, copy) NSString *shop_name;
/** 店铺id */
@property(nonatomic, copy) NSString *shop_id;

/** 本区是否全选 */
@property(nonatomic, assign,getter=isSelectAll) BOOL selectAll;

/** 本店铺下的商品 */
@property(nonatomic, copy) NSMutableArray <__kindof ZCPublicGoodsModel *>*shop_goods;

/** 读取本地购物车商品使用 */
- (instancetype)initWithName:(NSString *)name aid:(NSString *)aid selectAll:(BOOL)select goods:(NSArray *)goods;
@end

NS_ASSUME_NONNULL_END
