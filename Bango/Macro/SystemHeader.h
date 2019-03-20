//
//  SystemHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef SystemHeader_h
#define SystemHeader_h


//判断是否是ipad

//判断iPhone5系列
#define kiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhone6系列
#define kiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iphone6+系列
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

/** 获取适合屏幕的宽度 （x 宽度值(UI设计图上标注的) 注意： PX标注记得X2 ）*/
/** 获取适合屏幕的宽度 （x 宽度值(UI设计图上标注的) 注意： 单位pt ）*/
#define WidthRatio(x)     (x /375.0 * SCREEN_WIDTH )

/** 获取适合屏幕的高度值 （x 高度值(UI设计图上标注的) 注意： PX标注记得X2 ）*/
/** 获取适合屏幕的高度值 （x 高度值(UI设计图上标注的) 注意： 单位pt ）*/
#define HeightRatio(x)    (x /667.0 * SCREEN_HEIGHT )

/** 屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


//是否是iPhone X系列
#define iPhoneX (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max)

// 状态栏高度
#define StatusBarHeight (iPhoneX ? 44.f : 20.0f)

// 导航栏高度
#define NavBarHeight (iPhoneX ? 88.f : 64.f)

// tabBar高度
#define TabBarHeight (iPhoneX ? (83.f) : 49.f)

// 底部高度
#define HomeIndicatorHeight (iPhoneX ? 34.f : 0.f)

// 键盘高度
#define KeyBordHeight (iPhoneX ? 291.f : 226.f)

// iPhone X高度差
#define topDiff (iPhoneX ? 24.f : 0.f)

// 角度转换弧度
#define DegreesToRadian(degrees) (M_PI * (degrees) / 180.0)

// 弧度转换角度
#define RadianToDegrees(radian) (radian * 180.0) / (M_PI)

// 字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 字符串为空输入空的字符
#define StringJudgeEmpty(str)  (StringIsEmpty(str) ? @"" : str)

// 数组是否为空
#define ArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

// 字典是否为空
#define DictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

// 是否是空对象
#define ObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



// App版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 系统版本号
#define SystemVersion [[UIDevice currentDevice] systemVersion]

// 当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// Document路径
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// Temp路径
#define TempPath NSTemporaryDirectory()

// Cache路径
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 当前应用
#define Application [UIApplication sharedApplication]

// Medium字体
#define MediumFont(sizePX) [UIFont systemFontOfSize:WidthRatio(sizePX) weight:UIFontWeightMedium]
// Medium字体
#define BoldFont(sizePX) [UIFont boldSystemFontOfSize:sizePX]


// log 日志
#ifdef DEBUG
#define NSLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSLog( s, ... )
#endif


#endif /* SystemHeader_h */
