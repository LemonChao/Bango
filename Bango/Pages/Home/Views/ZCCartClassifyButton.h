//
//  ZCCartClassifyButton.h
//  Bango
//
//  Created by zchao on 2019/4/22.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartButton.h"

NS_ASSUME_NONNULL_BEGIN

@class ZCBaseGodsModel;

@interface ZCCartClassifyButton : UIButton
@property(nonatomic, copy) NSString *count;
@property (nonatomic, strong) ZCBaseGodsModel *baseModel;


@end

NS_ASSUME_NONNULL_END
