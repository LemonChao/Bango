//
//  ZCHomeRecommendCell.h
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomeRecommendCell : UITableViewCell

@property(nonatomic, copy) NSArray<ZCHomeTuijianModel *> *tuijianList;

@end

NS_ASSUME_NONNULL_END
