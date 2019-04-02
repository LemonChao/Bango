//
//  ZCHomeTuanCell.h
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TuanButtonClick)(ZCHomePintuanModel *);
@interface ZCHomeTuanCell : UITableViewCell

@property(nonatomic, copy) NSArray<__kindof ZCHomePintuanModel *> *pintuanList;

@property(nonatomic, copy) TuanButtonClick buttonBlock;
@end

NS_ASSUME_NONNULL_END
