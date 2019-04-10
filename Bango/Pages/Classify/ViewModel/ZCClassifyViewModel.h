//
//  ZCClassifyViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/4.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"
#import "ZCClassifyModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZCClassifyViewModel : ZCBaseViewModel

/** 分类页数据 */
@property(nonatomic, strong) RACCommand *classifyCmd;


@property(nonatomic, strong) NSArray <ZCClassifyModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
