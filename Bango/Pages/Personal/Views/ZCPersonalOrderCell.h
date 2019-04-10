//
//  ZCPersonalOrderCell.h
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPersonalCenterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCPersonalOrderCell : UITableViewCell

@property(nonatomic, strong) ZCPersonalCenterModel *model;

@end




@interface ZCBadgeButton : UIControl

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, copy) NSString *title;


@property(nullable, nonatomic, copy) NSString *badgeValue;    // default is nil

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title badge:(NSString *)badge;

@end

NS_ASSUME_NONNULL_END
