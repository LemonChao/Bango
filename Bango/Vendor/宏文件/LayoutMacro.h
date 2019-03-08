//
//  LayoutMacro.h
//  LiveTest
//
//  Created by 张海彬 on 2018/1/25.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#ifndef LayoutMacro_h
#define LayoutMacro_h

//颜色的宏
#define SUBJECTCOLOR  [UIColor blackColor]


/** 获取mainScreen的bounds */
#define MMScreenBounds [[UIScreen mainScreen] bounds]

/** 屏幕宽度 */
#define SCREEN_WIDTH    MMScreenBounds.size.width

/** 屏幕高度 */
#define SCREEN_HEIGHT   MMScreenBounds.size.height

/** 是否是IPhoneX */
#define IS_IPHONE_X (SCREEN_HEIGHT == 812.0f) ? YES : NO

/** 获取适合屏幕的宽度 （x 宽度值(UI设计图上标注的) 注意： PX标注记得X2 ）*/
#define WidthRatio(x)     (SCREEN_HEIGHT == 812.0 ? x/2 :x /750.0 * SCREEN_WIDTH )

/** 获取适合屏幕的高度值 （x 高度值(UI设计图上标注的) 注意： PX标注记得X2）*/
#define HeightRatio(x)    ( SCREEN_HEIGHT == 812.0 ? x/2 :x /1334.0 * SCREEN_HEIGHT )


#define Height_NavContentBar 44.0f

/** 状态栏高度 */
#define HeightStatus (IS_IPHONE_X==YES)?44.0f:20.0f

/** 导航栏高度 */
#define NavBarHeight (IS_IPHONE_X==YES)?88.0f:64.0f

/** TabBar高度 */
#define TabBarHeight (IS_IPHONE_X==YES)?83.0f:49.0f

//没有Tabar底部距离宏
#define HJBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)

#endif /* LayoutMacro_h */
