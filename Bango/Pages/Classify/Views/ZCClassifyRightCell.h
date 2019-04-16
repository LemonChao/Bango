//
//  ZCClassifyRightCell.h
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCClassifyRightCell : UITableViewCell

@property(nonatomic, strong) UIView *lineView;

//@property(nonatomic, strong) ZCClassifyGodsModel *model;
@property(nonatomic, strong) ZCPublicGoodsModel *model;


@end

NS_ASSUME_NONNULL_END
