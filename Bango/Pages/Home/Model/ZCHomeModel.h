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
@interface ZCHomeAdvModel : NSObject

@property(nonatomic, copy) NSString *adv_id;

@property(nonatomic, copy) NSString *adv_image;

@property(nonatomic, copy) NSString *adv_title;

@property(nonatomic, copy) NSString *adv_url;

@property(nonatomic, copy) NSString *goods_id;

@property(nonatomic, copy) NSString *gotype;

@end
/// 水果分类
@interface ZCHomeCategoryModel : NSObject
//"category_id":1,
//"category_name":"水果区",
//"category_pic":"http://ceshi.mr-bango.cn/upload/goods_category/1546085960.png",
//"short_name":"水果区"
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *category_name;
@property(nonatomic, copy) NSString *category_pic;
@property(nonatomic, copy) NSString *short_name;
@end

/// 公告
@interface ZCHomeNoticeModel : NSObject
//"id":11,
//"notice_title":"这还是一条测试未读公告",
//"notice_content":"<p>这还是一条测试未读公告这还是一条测试未读公告这还是一条测试未读公告这还是一条测试未读公告这还是一条测试未读公告这还是一条测试未读公告</p>",
//"shop_id":0,
//"sort":0,
//"create_time":1553652604,
//"modify_time":0
@property(nonatomic, copy) NSString *notice_id;
@property(nonatomic, copy) NSString *notice_title;
@property(nonatomic, copy) NSString *notice_content;
@property(nonatomic, copy) NSString *shop_id;
@property(nonatomic, copy) NSString *sort;
@property(nonatomic, copy) NSString *create_time;
@property(nonatomic, copy) NSString *modify_time;

@end

/// 爆款推荐
@interface ZCHomeTuijianModel : NSObject
//"goods_id":21,
//"introduction":"备注：甘肃 青海 宁夏 新疆 西藏 东北云南，偏寒偏远地区不发货",
//"goods_name":"海南现摘现发金都一号红心火龙果10斤空运",
//"goods_type":1,
//"is_hot":1,
//"is_new":0,
//"is_recommend":1,
//"market_price":"0.00",
//"max_buy":0,
//"pic_cover_mid":"http://ceshi.mr-bango.cn/upload/goods/20190112/493322b2d8df3fdb1a2e3d433674063c2.jpg",
//"pic_cover_small":"http://ceshi.mr-bango.cn/upload/goods/20190112/493322b2d8df3fdb1a2e3d433674063c3.jpg",
//"promotion_price":"238.00",
//"sales":89,
//"state":1,
//"stock":58
@property(nonatomic, copy) NSString *goods_id;
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
@interface ZCHomePintuanModel : NSObject
//"goods_id":71,
//"goods_name":"中华红血橙——老少皆宜的好东西 净果9斤装（中大果）",
//"introduction":"水果界的“暖男”。只有不到1%的人，吃过这颗中华红血橙！",
//"promotion_price":"88.00",
//"pic_cover_mid":"http://ceshi.mr-bango.cn/upload/goods/20181212/a26694d5af5838b63456f2687a80d3df2.jpg",
//"shop_name":"搬果将水果商城",
//"is_open":1,
//"is_show":1,
//"is_coupon":1,
//"tuangou_money":"0.01",
//"tuangou_num":2,
//"tuangou_type":1,
//"tuangou_type_name":"普通拼团",
//"tuangou_id":1551,
//"max_buy":1,
//"start_time":1554134400,
//"end_time":1554307200,
//"colonel_content":"杨康专属拼团"
@property(nonatomic, copy) NSString *goods_id;
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
@interface ZCHomeGodsModel : NSObject

@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *introduction;
@property(nonatomic, copy) NSString *group_id_array;
@property(nonatomic, copy) NSString *is_hot;
@property(nonatomic, copy) NSString *is_new;
@property(nonatomic, copy) NSString *is_recommend;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *pic_cover_small;
@property(nonatomic, copy) NSString *colonel_content;
@property(nonatomic, copy) NSString *point_exchange;
@property(nonatomic, copy) NSString *point_exchange_type;
@property(nonatomic, copy) NSString *promotion_price;
@property(nonatomic, copy) NSString *shipping_fee;
@property(nonatomic, copy) NSString *state;

@end

//@interface ZCHomeSectionModel : NSObject
//@property(nonatomic, copy) NSString *category_alias;
//
///** 分区内行高 */
//@property(nonatomic, assign) CGFloat rowHeight;
//
//@property(nonatomic, copy) NSArray *goods_list;
//@end
/// 每个详细分类<搬果小将，水果区...>
@interface ZCHomeEverygodsModel : NSObject
//    "category_alias":"水果区",
//    "category_id":1,
//    "goods_sort_type":2,
//    "goods_list":[
//              {
//                  "goods_id":24,
//                  "goods_name":"爱心传递能量每一次的传递都是爱的奉献",
//                  "introduction":"圆开水果店的梦，绿色健康水果",
//                  "group_id_array":"0",
//                  "group_list":[
//                  ],
//                  "is_hot":0,
//                  "is_new":0,
//                  "is_recommend":0,
//                  "market_price":"0.00",
//                  "pic_cover_small":"http://ceshi.mr-bango.cn/upload/goods/20181102/f04796730763a3b8efc658f33d29f54a3.jpg",
//                  "point_exchange":0,
//                  "point_exchange_type":0,
//                  "promotion_price":"368.00",
//                  "shipping_fee":"0.00",
//                  "state":1
//              },
@property(nonatomic, copy) NSString *category_alias;
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *goods_sort_type;
//@property(nonatomic, copy) NSArray<__kindof ZCHomeGodsModel *> *goods_list;
@property(nonatomic, copy) NSArray *goods_list;

/** 分区内行高 */
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic, assign) CGFloat headerHeight;
@property(nonatomic, assign) CGFloat footerHeight;

@end




@interface ZCHomeModel : ZCBaseModel


@property(nonatomic, copy) NSArray <__kindof ZCHomeAdvModel *> *lunbo;

@property(nonatomic, copy) NSArray <__kindof ZCHomeCategoryModel *> *categoryList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeNoticeModel *> *noticeList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeTuijianModel *> *tuijianList;

@property(nonatomic, copy) NSArray <__kindof ZCHomePintuanModel *> *pintuanList;

@property(nonatomic, copy) NSArray <__kindof ZCHomeEverygodsModel *> *everyGods;

@property(nonatomic, strong) ZCHomeEverygodsModel *bango;

@end



NS_ASSUME_NONNULL_END
