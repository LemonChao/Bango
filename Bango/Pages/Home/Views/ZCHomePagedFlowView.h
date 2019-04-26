//
//  ZCHomePagedFlowView.h
//  Bango
//
//  Created by zchao on 2019/4/25.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseView.h"
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomePagedFlowView : ZCBaseView

@property(nonatomic, copy) NSArray <__kindof ZCHomeAdvModel *> *lunbos;

@end

NS_ASSUME_NONNULL_END
