//
//  ZCHomeNoticeCell.h
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomeNoticeCell : UITableViewCell

@property(nonatomic, copy) NSArray<__kindof ZCHomeNoticeModel *> *notics;

@end

NS_ASSUME_NONNULL_END
