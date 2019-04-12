//
//  ZCCartButton.h
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZCBaseGodsModel;
@interface ZCCartButton : UIButton

@property(nonatomic, copy) NSString *count;
@property (nonatomic, strong) ZCBaseGodsModel *baseModel;

@end

NS_ASSUME_NONNULL_END
