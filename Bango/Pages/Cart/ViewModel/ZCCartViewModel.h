//
//  ZCCartViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCCartTuijianModel.h"
#import "ZCCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCCartViewModel : ZCBaseViewModel

@property(nonatomic, strong) RACCommand *emptyCartCmd;

@property(nonatomic, copy) NSArray<__kindof ZCCartTuijianModel *> *tuijianDatas;

@property(nonatomic, strong) RACCommand *netCartCmd;

/** 购物车商品总数据 */
@property(nonatomic, copy) NSArray <__kindof ZCCartModel *> *cartDatas;

/** 只有推荐 */
@property(nonatomic, assign) BOOL onlyTuijian;

/** 购物车保存本地的商品 */
@property(nonatomic, copy) NSArray *localGods;
@end

NS_ASSUME_NONNULL_END
