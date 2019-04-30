//
//  ZCNewsCenterCell.h
//  Bango
//
//  Created by zchao on 2019/4/28.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZCSystemNoticeVM;

@interface ZCNewsCenterCell : UITableViewCell

@property(nonatomic, strong) ZCSystemNoticeVM *cellViewModel;

@end

NS_ASSUME_NONNULL_END
