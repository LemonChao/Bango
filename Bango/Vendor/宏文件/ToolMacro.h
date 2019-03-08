//
//  ToolMacro.h
//  LiveTest
//
//  Created by 张海彬 on 2018/1/26.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

#pragma mark property属性快速声明
/** 声明NSString属性 */
#define PropertyString(s)@property(nonatomic,copy)NSString * s
/** 声明NSIntegers属性 */
#define PropertyNSInteger(s)@property(nonatomic,assign)NSInteger *s
/** 声明NSNumber属性 */
#define PropertyNSNumber(s)@property (nonatomic,strong)NSNumber *s
/** 声明floats属性 */
#define PropertyFloat(s)@property(nonatomic,assign)floats
/** 声明long long属性 */
#define PropertyLongLong(s)@property(nonatomic,assign)long long s
/** 声明NSDictionary属性 */
#define PropertyNSDictionary(s)@property(nonatomic,strong)NSDictionary * s
/** 声明NSArray属性 */
#define PropertyNSArray(s)@property(nonatomic,strong)NSArray * s
/** 声明NSMutableArray属性 */
#define PropertyNSMutableArray(s)@property(nonatomic,strong)NSMutableArray * s
/** 声明UITextField */
#define PropertyUITextField(s)@property(nonatomic,strong)UITextField * s

#define PropertyUI(UI,s)@property(nonatomic,strong)UI * s
#pragma mark 拼接字符串
/**拼接字符串(用法：NSStringFormat(@"5s%@",@"str"))*/
#define MMNSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

#pragma mark 数据验证
/** 验证字符串是否包含 */
#define HasString(str,eky)([str rangeOfString:key].location!=NSNotFound)
/** 验证是否是字典 */
#define ValidDict(f)(f!=nil &&[f isKindOfClass:[NSDictionary class]])
/** 验证是否是数组 */
#define ValidArray(f)(f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)
/** 验证是否是NSNumber */
#define ValidNum(f)(f!=nil &&[f isKindOfClass:[NSNumber class]])
/** 验证是否是某个类型的 */
#define ValidClass(f,cls)(f!=nil &&[f isKindOfClass:[cls class]])
/** 验证是否是NSData */
#define ValidData(f)(f!=nil &&[f isKindOfClass:[NSData class]])

/** RGB颜色转换 */
#define MMColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define MMBasicColor MMColor(214, 41, 117)

#define MMRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
/** 多语言字体选择 */
#define ChooseWord(wordName,wordFile)  NSLocalizedStringFromTable(wordName,wordFile, nil)
/**
 *  字体
 */
#define MMFont(size) [UIFont systemFontOfSize:size]
#define MMBlodFont(size) [UIFont boldSystemFontOfSize:size]

/** 十六进制颜色转换 */
#define HEX_COLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

/** 弱引用（防止强制引用） */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/** 获取图片资源 */
#define MMGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/** 自定义高效率的 NSLog */
#ifdef DEBUG
#define MMLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define MMLog(...)
#endif
/** 设置view圆角和边框 */
#define MMViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 角度转换弧度*/
#define MMDegreesToRadian(x) (M_PI * (x) / 180.0)
/** 弧度转换角度 */
#define MMRadianToDegrees(radian) (radian*180.0)/(M_PI)

/** 获取temp */
#define kPathTemp NSTemporaryDirectory()
/** 获取沙盒 Document */
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/** 获取沙盒 Cache */
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/** GCD - 一次性执行(GCD写单例用的) */
#define MMISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
/** GCD - 在Main线程上运行(获取主线程，并执行) */
#define MMISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/** GCD - 开启异步线程(开启分线程) */
#define MMISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
/** NSUserDefaults宏 */
#define MMNSUserDefaults    [NSUserDefaults standardUserDefaults]
/**===================获取手机型号相关===========================*/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

/**IPhone4*/
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
/**IPhone5*/
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
/**IPhone6*/
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
/**IPhone6P*/
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
/** 是否是IPhoneX */
//#define IS_IPHONE_X  (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
#endif /* ToolMacro_h */
