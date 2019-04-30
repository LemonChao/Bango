//
//  UIView+BadgeValue.h
//  Bango
//
//  Created by zchao on 2019/4/28.
//  Copyright © 2019 zchao. All rights reserved.
//
// 在view右上角显示角标


NS_ASSUME_NONNULL_BEGIN

@interface UIView (BadgeValue)

/** nil或< 0 :角标隐藏  >0 :显示角标数字  =0 :显示红点 */
@property(nullable, nonatomic, copy) NSString *badgeValue;

@end

NS_ASSUME_NONNULL_END
