//
//  ZCCartViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCCartTuijianModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCCartViewModel : ZCBaseViewModel

@property(nonatomic, strong) RACCommand *emptyCartCmd;

@property(nonatomic, copy) NSArray<__kindof ZCCartTuijianModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
