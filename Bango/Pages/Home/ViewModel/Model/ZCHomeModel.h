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

/// 每个详细分类<搬果小将，水果区...>
@interface ZCHomeEverygodsModel : ZCBaseGodsModel
@property(nonatomic, copy) NSString *category_alias;
@property(nonatomic, copy) NSString *category_id;
@property(nonatomic, copy) NSString *category_search_type;
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
