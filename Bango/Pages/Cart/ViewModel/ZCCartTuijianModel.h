//
//  ZCCartTuijianModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCCartTuijianModel : ZCBaseModel

//"goods_id": 21,
//"goods_name": "海南现摘现发金都一号红心火龙果10斤空运",
//"introduction": "备注：甘肃 青海 宁夏  新疆 西藏 东北云南，偏寒偏远地区不发货",
//"pic_cover_mid": "http://ceshi.mr-bango.cn/upload/goods/20190112/493322b2d8df3fdb1a2e3d433674063c2.jpg",
//"market_price": "0.00",
//"promotion_price": "238.00",
//"goods_type": 1,
//"stock": 58,
//"pic_id": 1095,
//"max_buy": 0,
//"state": 1,
//"is_hot": 1,
//"is_recommend": 1,
//"is_new": 0,
//"sales": 89,
//"pic_cover_small": "http://ceshi.mr-bango.cn/upload/goods/20190112/493322b2d8df3fdb1a2e3d433674063c3.jpg"

@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *introduction;
@property(nonatomic, copy) NSString *pic_cover_mid;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *promotion_price;
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

@end

NS_ASSUME_NONNULL_END
