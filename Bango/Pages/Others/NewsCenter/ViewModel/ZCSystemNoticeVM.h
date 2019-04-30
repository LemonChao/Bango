//
//  ZCSystemNoticeVM.h
//  Bango
//
//  Created by zchao on 2019/4/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCSystemNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCSystemNoticeVM : ZCBaseViewModel

/** 系统公告-首页 */
@property(nonatomic, strong) RACCommand *noticeCmd;

/** 系统公告列表 */
@property(nonatomic, strong) RACCommand *noticeListCmd;

@property(nonatomic, copy) NSArray<__kindof ZCSystemNoticeModel*> *dataArray;

/** 是否已读 0:未读(需要提醒) 1:已读 default YES*/
@property(nonatomic, assign, getter=isReaded) BOOL readed;

@property(nonatomic, copy) NSString *showTime;
@end

NS_ASSUME_NONNULL_END
