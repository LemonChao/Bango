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

@property(nonatomic, strong) ZCHomeModel *home;

@property(nonatomic, copy) NSArray *dataArray;

@property(nonatomic, copy) NSArray *advImages;

@end

NS_ASSUME_NONNULL_END
