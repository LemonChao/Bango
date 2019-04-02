//
//  MBProgressHUD+ZChao.h
//  HtmlLoad
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (ZChao)

/**
 中间显示

 @param text 显示内容
 */
+ (void)showText:(nullable NSString *)text;


/**
 顶部显示

 @param text 显示内容
 */
+ (void)showTopText:(nullable NSString *)text;


/**
 底部显示

 @param text 显示内容
 */
+ (void)showBottomText:(nullable NSString *)text;


/**
 Activity + text
 在window上 text为nil或@"" 只显示 Activity
 @param text 显示内容
 */
+ (void)showActivityText:(nullable NSString *)text;



/**
 Activity + text
 在window上 text为nil或@"" 只显示 Activity

 @param text text
 @param view superView
 */
+ (void)showActivityText:(nullable NSString *)text inView:(UIView *)view;


+ (instancetype)showHudMode:(MBProgressHUDMode)model text:(nullable NSString *)text;


+ (void)hideHud;

+ (void)hideAnimated:(BOOL)animated;


+ (void)hideAnimated:(BOOL)animated After:(NSTimeInterval)after;
@end

NS_ASSUME_NONNULL_END
