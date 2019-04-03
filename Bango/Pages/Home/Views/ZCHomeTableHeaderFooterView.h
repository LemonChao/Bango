//
//  ZCHomeTableHeaderFooterView.h
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCHomeTableHeaderView : UITableViewHeaderFooterView

@property(nonatomic, strong) ZCHomeEverygodsModel *model;

@end

@interface ZCHomeTableFooterView : UITableViewHeaderFooterView

@end


@interface ZCHomeBlankTableHeaderFooterView : UITableViewHeaderFooterView

@end



NS_ASSUME_NONNULL_END
