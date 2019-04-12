//
//  ZCCartEmptySectionHeader.h
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCCartModel.h"

NS_ASSUME_NONNULL_BEGIN

// 空空如也header
@interface ZCCartEmptySectionHeader : UICollectionReusableView

@end


// 猜你喜欢header
@interface ZCCartTuijianSectionHeader : UICollectionReusableView

@end

// 商店header
@interface ZCCartShopNameSctionHeader : UICollectionReusableView

@property(nonatomic, strong) ZCCartModel *model;

@end


// 失效header
@interface ZCCartInvaluedSectionHeader : UICollectionReusableView

@end


NS_ASSUME_NONNULL_END
