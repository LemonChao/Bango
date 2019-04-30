//
//  ZCSystemNoticeModel.h
//  Bango
//
//  Created by zchao on 2019/4/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCSystemNoticeModel : ZCBaseModel

/** 是否已读 0:未读(需要提醒) 1:已读 */
@property(nonatomic, copy) NSString *is_read;
@property(nonatomic, copy) NSString *aid;
@property(nonatomic, copy) NSString *notice_title;
@property(nonatomic, copy) NSString *create_time;
@property(nonatomic, copy) NSString *showTime;


@end

NS_ASSUME_NONNULL_END
