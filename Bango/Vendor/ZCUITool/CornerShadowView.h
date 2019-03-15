//
//  CornerShadowView.h
//  RegistrationHall
//
//  Created by zchao on 2018/6/8.
//  Copyright © 2018年 Toushi. All rights reserved.
//

#import <UIKit/UIKit.h>

//圆角带阴影
@interface CornerShadowView : UIView

@property(nonatomic, strong) UIColor *fillColor;

/** 阴影颜色 default black*/
@property(nonatomic, strong) UIColor *shadowColor;

/** 阴影偏移量  default {0,0}*/
@property(nonatomic, assign) CGSize shadowOffset;

/** 边框跟控件边缘的内边距 default 5*/
@property(nonatomic, assign) UIEdgeInsets boardInsets;

/** 圆角半径 */
@property(nonatomic, assign) CGFloat cornerRadius;

/** 阴影模糊系数 值越大，越模糊，0:不模糊
 值越大，阴影面积就越大, default 5.0
 */
@property(nonatomic, assign) CGFloat blur;



@end
