//
//  ZCHomeViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomeViewModel : ZCBaseViewModel

/** 首页数据 */
@property(nonatomic, strong) RACCommand *homeCmd;

@property(atomic, strong) ZCHomeModel *home;

@property(atomic, copy) NSArray *dataArray;

@property(atomic, copy) NSArray *advImages;

/** 是否存在拼团 */
@property(nonatomic, assign, getter=hasTuan) BOOL tuan;

@end

NS_ASSUME_NONNULL_END
