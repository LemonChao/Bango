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

/**
 刷新webview
 */
-(void)refreshWebView;

- (void)bridgeCallHandler:(NSString *)handleName data:(id)data;

@end

NS_ASSUME_NONNULL_END
