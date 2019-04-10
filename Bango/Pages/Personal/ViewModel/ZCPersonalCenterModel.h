//
//  ZCPersonalCenterModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@class ZCPersonalAdvModel;
@interface ZCPersonalCenterModel : ZCBaseModel
//"continuous_signs": 0,
//"is_sign": 0,
//"platforms": [
//              {
//                  "adv_image": "http://ceshi.mr-bango.cn/upload/image_collection/1554705180.jpg",
//                  "adv_url": "http://ceshi.mr-bango.cn"
//              },
//              {
//                  "adv_image": "http://ceshi.mr-bango.cn/upload/image_collection/1554705288.jpg",
//                  "adv_url": "https://mr-bango.cn"
//              }
//              ],
//"pay_ords": 1,
//"fa_ords": 0,
//"shou_ords": 0,
//"virtual_wait_evaluate": 0,
//"refund_ords": 0,
//"xf_kui": "0.00",
//"fx_kou": "0.00",
//"team_jiang": "0.00",
//"avatarhead": "http://ceshi.mr-bango.cn/upload/web_common/default_head.png",
//"user_name": "zhengchao110",
//"nick_name": "zhengchao110",
//"jibie": "普通会员",
//"tot_money": "8888888.00",
//"tui_count": 1,
//"rz_status": "2",
//"tx_pwd_status": 1

/** 余额 */
@property(nonatomic, copy) NSString *tot_money;
/** 签到 */
@property(nonatomic, copy) NSString *continuous_signs;
/** 粉丝 */
@property(nonatomic, copy) NSString *tui_count;
/** 是否签到 */
@property(nonatomic, copy) NSString *is_sign;
/** 待支付数量 */
@property(nonatomic, copy) NSString *pay_ords;
/** 待发货 */
@property(nonatomic, copy) NSString *fa_ords;
/** 待退款 */
@property(nonatomic, copy) NSString *refund_ords;
/** 待收货 */
@property(nonatomic, copy) NSString *shou_ords;
/** 待评价 */
@property(nonatomic, copy) NSString *virtual_wait_evaluate;
/** 头像 */
@property(nonatomic, copy) NSString *avatarhead;
/** 昵称 */
@property(nonatomic, copy) NSString *user_name;

@property(nonatomic, copy) NSArray<__kindof ZCPersonalAdvModel *> *platforms;

//@property(nonatomic, copy) NSString *avatarhead;
//@property(nonatomic, copy) NSString *avatarhead;
//@property(nonatomic, copy) NSString *avatarhead;
//@property(nonatomic, copy) NSString *avatarhead;
//@property(nonatomic, copy) NSString *avatarhead;
//

@end

@interface ZCPersonalAdvModel : ZCBaseModel

/** 广告位图片 */
@property(nonatomic, copy) NSString *adv_image;
/** 跳转链接 */
@property(nonatomic, copy) NSString *adv_url;

@end



NS_ASSUME_NONNULL_END
