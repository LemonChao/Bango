//
//  ZCHomeModel.h
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 轮播图
@interface ZCHomeAdvModel : ZCBaseGodsModel

@property(nonatomic, copy) NSString *adv_id;

@property(nonatomic, copy) NSString *adv_image;

@property(nonatomic, copy) NSString *adv_title;

@property(nonatomic, copy) NSString *adv_url;

//@property(nonatomic, copy) NSString *goods_id;

@property(nonatomic, copy) NSString *gotype;

@end
/// 水果分类
@interface ZCHomeCategoryModel : ZCBaseGodsModel
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *category_name;
@property(nonatomic, copy) NSString *category_pic;
@property(nonatomic, copy) NSString *short_name;
@end

/// 公告
@interface ZCHomeNoticeModel : ZCBaseGodsModel
@property(nonatomic, copy) NSString *notice_id;
@property(nonatomic, copy) NSString *notice_title;
@property(nonatomic, copy) NSString *notice_content;
@property(nonatomic, copy) NSString *shop_id;
@property(nonatomic, copy) NSString *sort;
@property(nonatomic, copy) NSString *create_time;
@property(nonatomic, copy) NSString *modify_time;

@end

/// 爆款推荐
@interface ZCHomeTuijianModel : ZCBaseGodsModel
//@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *introduction;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *goods_type;
@property(nonatomic, copy) NSString *is_hot;
@property(nonatomic, copy) NSString *is_new;
@property(nonatomic, copy) NSString *is_recommend;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *max_buy;
@property(nonatomic, copy) NSString *pic_cover_mid;
@property(nonatomic, copy) NSString *pic_cover_small;
@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *sales;
@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSString *stock;

@end


/// 拼团
@interface ZCHomePintuanModel : ZCBaseGodsModel
//@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *introduction;
@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *pic_cover_mid;
@property(nonatomic, copy) NSString *tuangou_id;
@property(nonatomic, copy) NSString *shop_name;
@property(nonatomic, copy) NSString *is_open;
@property(nonatomic, copy) NSString *is_show;
@property(nonatomic, copy) NSString *is_coupon;
@property(nonatomic, copy) NSString *stock;
@property(nonatomic, copy) NSString *tuangou_money;
@property(nonatomic, copy) NSString *tuangou_num;
@property(nonatomic, copy) NSString *tuangou_type;
@property(nonatomic, copy) NSString *tuangou_type_name;
@property(nonatomic, copy) NSString *max_buy;
@property(nonatomic, copy) NSString *start_time;
@property(nonatomic, copy) NSString *end_time;
@property(nonatomic, copy) NSString *colonel_content;


@end

/// gods model
//@interface ZCHomeGodsModel : ZCBaseGodsModel
////@property(nonatomic, copy) NSString *goods_id;
////@property(nonatomic, copy) NSString *goods_name;
////@property(nonatomic, copy) NSString *introduction;
////@property(nonatomic, copy) NSString *is_hot;
////@property(nonatomic, copy) NSString *is_new;
////@property(nonatomic, copy) NSString *is_recommend;
////@property(nonatomic, copy) NSString *market_price;
////@property(nonatomic, copy) NSString *pic_cover_small;
//@property(nonatomic, copy) NSString *colonel_content;
//@property(nonatomic, copy) NSString *point_exchange;
//@property(nonatomic, copy) NSString *point_exchange_type;
////@property(nonatomic, copy) NSString *promotion_price;
//@property(nonatomic, copy) NSString *shipping_fee;
////@property(nonatomic, copy) NSString *state;
//
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
//
//@end


/// 每个详细分类<搬果小将，水果区...>
@interface ZCHomeEverygodsModel : ZCBaseGodsModel
@property(nonatomic, copy) NSString *category_alias;
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *goods_sort_type;
@property(nonatomic, copy) NSArray *goods_list;

/** 分区内行高 */
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic, assign) CGFloat headerHeight;
@property(nonatomic, assign) CGFloat footerHeight;

@end




@interface ZCHomeModel : ZCBaseGodsModel

@property(nonatomic, copy) NSArray <__kindof ZCHomeAdvModel *> *lunbo;

@property(nonatomic, copy) NSArray <__kindof ZCHomeCategoryModel *> *categoryList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeNoticeModel *> *noticeList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeTuijianModel *> *tuijianList;

@property(nonatomic, copy) NSArray <__kindof ZCHomePintuanModel *> *pintuanList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeEverygodsModel *> *everyGods;

@property(nonatomic, strong) ZCHomeEverygodsModel *bango;

@end



NS_ASSUME_NONNULL_END
