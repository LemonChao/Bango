//
//  ZCHomeCategoryCell.h
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ButtonClick)(ZCHomeCategoryModel *);

@interface ZCHomeCategoryCell : UITableViewCell

@property(nonatomic, copy) NSArray<__kindof ZCHomeCategoryModel *> *categoryList;

@property(nonatomic, copy) ButtonClick buttonBlock;

@end

NS_ASSUME_NONNULL_END
