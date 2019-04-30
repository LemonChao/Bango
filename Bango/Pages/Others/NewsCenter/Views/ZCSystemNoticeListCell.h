//
//  ZCSystemNoticeListCell.h
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZCSystemNoticeModel;

@interface ZCSystemNoticeListCell : UITableViewCell

@property(nonatomic, strong) ZCSystemNoticeModel *model;

@end

NS_ASSUME_NONNULL_END
