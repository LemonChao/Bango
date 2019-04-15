//
//  ZCCartValueCollectionCell.h
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCCartValueCollectionCell : UICollectionViewCell

@property(nonatomic, strong) ZCPublicGoodsModel *model;

@property(nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
