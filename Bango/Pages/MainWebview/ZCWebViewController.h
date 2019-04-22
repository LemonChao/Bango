//
//  ZCWebViewController.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZCWebViewController : ZCBaseViewController

/**
 是否隐藏返回按钮
 */
@property (nonatomic,assign)BOOL isHidenLeft;
/** 是否从状态栏开始布局 NO:是的 YES：不是*/
@property (nonatomic,assign)BOOL isTop;
/** 直接加载URL*/
@property (nonatomic,copy)NSString *urlString;
/**拼接的URL参数*/
@property (nonatomic,copy)NSString *jointParameter;
/**文件名*/
@property (nonatomic,copy)NSString *fileName;
/**导航隐藏*/
@property (nonatomic,assign)BOOL isNavigationHidden;
/** 标题 */
@property (nonatomic,copy)NSString *webTitle;
/** 顶部间距 */
@property(nonatomic, assign) CGFloat topInset;
/** 底部间距 */
@property(nonatomic, assign) CGFloat bottomInset;
/** h5 页面路径*/
@property(nonatomic, copy) NSString *pathForH5;
/** h5 页面参数*/
@property(nonatomic, copy) NSDictionary *parameters;

/**
 刷新webview
 */
//-(void)refreshWebView;
- (instancetype)initWithPath:(NSString *)path parameters:(nullable NSDictionary *)parameters;
- (void)bridgeCallHandler:(NSString *)handleName data:(id)data;

@end

NS_ASSUME_NONNULL_END
