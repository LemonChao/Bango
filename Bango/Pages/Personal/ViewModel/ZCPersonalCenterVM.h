//
//  ZCPersonalCenterVM.h
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCPersonalCenterModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZCPersonalCenterVM : ZCBaseViewModel

/** 会员中心 */
@property(nonatomic, strong) RACCommand *memberCmd;

@property(nonatomic, strong) ZCPersonalCenterModel *model;

@end

NS_ASSUME_NONNULL_END
