//
//  AppColorHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef AppColorHeader_h
#define AppColorHeader_h

/** 十六进制颜色转换 */
#define HEX_COLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

// rgb三原色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 背景 - f5f6f7 */
#define BackGroundColor HEX_COLOR(0xffffff)

/** 线条 - f5f5f5 */
#define LineColor RGBA(245,245,245,1)

/** 重要 - 333333 */
#define ImportantColor RGBA(51,51,51,1)

/** 一级 - 4a4a4a */
#define PrimaryColor RGBA(74,74,74,1)

/** 次要 - 666666 */
#define MinorColor RGBA(102,102,102,1)

/** 辅助 - 999999 */
#define AssistColor RGBA(153,153,153,1)

/** 通用红 FC5E62 */
#define GeneralRedColor RGBA(252,94,98)


#endif /* AppColorHeader_h */
