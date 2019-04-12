//
//  ZCClassifyModel.h
//  Bango
//
//  Created by zchao on 2019/4/4.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCClassifyGodsModel : ZCBaseGodsModel

//@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *pic_cover_mid;
@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *goods_type;
@property(nonatomic, copy) NSString *stock;
@property(nonatomic, copy) NSString *pic_id;
@property(nonatomic, copy) NSString *max_buy;
@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSString *is_hot;
@property(nonatomic, copy) NSString *is_recommend;
@property(nonatomic, copy) NSString *is_new;
@property(nonatomic, copy) NSString *sales;
@property(nonatomic, copy) NSString *pic_cover_small;
@property(nonatomic, copy) NSString *group_id_array;
@property(nonatomic, copy) NSString *shipping_fee;
@property(nonatomic, copy) NSString *point_exchange_type;
@property(nonatomic, copy) NSString *point_exchange;
@property(nonatomic, copy) NSString *is_favorite;
//@property(nonatomic, copy) NSString *sku_list;
//@property(nonatomic, copy) NSString *gorup_list;
@property(nonatomic, copy) NSString *display_price;


@end



//{
//    "category_id": 14,
//    "category_name": "水果礼盒",
//    "short_name": "水果礼盒",
//    "pid": 0,
//    "category_pic": "http://ceshi.mr-bango.cn/http://ceshi.mr-bango.cn/upload/goods_category/1546085998.png",
//    "count": 0,
//    "good_list": [
//                  {
//                      "goods_id": 109,
//                      "category_id": 14,
//                      "goods_name": "黄桃罐头--一口香甜，营养更美味6罐礼盒装",
//                      "pic_cover_mid": "upload/goods/20190111/80ccfe0f30f70a81fcc91d5b073c2d282.png",
//                      "promotion_price": "68.00",
//                      "market_price": "0.00",
//                      "goods_type": 1,
//                      "stock": 981,
//                      "pic_id": 1054,
//                      "max_buy": 1,
//                      "state": 1,
//                      "is_hot": 1,
//                      "is_recommend": 1,
//                      "is_new": 1,
//                      "sales": 20,
//                      "pic_cover_small": "upload/goods/20190111/80ccfe0f30f70a81fcc91d5b073c2d283.png",
//                      "group_id_array": "0",
//                      "shipping_fee": "0.00",
//                      "point_exchange_type": 0,
//                      "point_exchange": 0,
//                      "is_favorite": 0,
//                      "sku_list": [],
//                      "gorup_list": [],
//                      "display_price": "68.00"
//                  },
@interface ZCClassifyModel : ZCBaseGodsModel

@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *category_name;
@property(nonatomic, copy) NSString *short_name;
@property(nonatomic, copy) NSString *pid;
@property(nonatomic, copy) NSArray <__kindof ZCClassifyGodsModel *>*good_list;

@end

NS_ASSUME_NONNULL_END
