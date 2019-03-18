//
//  MethodHeader.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#ifndef MethodHeader_h
#define MethodHeader_h

/**拼接字符串(用法：StringFormat(@"5s%@",@"str")*/
#define StringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

/** 获取图片资源 */
#define ImageNamed(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//response返回的判断
#define kStatusTrue   ([responseObject[@"status"] integerValue] == 0)



/** 设置view圆角和边框 */
#define MMViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#endif /* MethodHeader_h */
