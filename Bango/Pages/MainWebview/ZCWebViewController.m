//
//  ZCWebViewController.m
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCWebViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import "WeakWebViewScriptMessageDelegate.h"
#import "ScriptMessageHandler.h"
#import "PaymentDelegateManager.h"
#import "DHGuidePageHUD.h"

#import "ZCBaseNavigationController.h"
#import "ZCLoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "ShareObject.h"
#import "RealNameAuthenticationVC.h"
#import "UIViewController+LKBubbleView.h"



@interface ZCWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) WKWebViewJavascriptBridge *bridge;

@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webViewLoadRequest];
    [self.bridge setWebViewDelegate:self];
    
}

- (void)configViews {
    [self.view addSubview:self.webView];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:showGuodePageKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:showGuodePageKey];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:@[@"guide_1",@"guide_2",@"guide_3"] buttonIsHidden:NO];
        [[UIApplication sharedApplication].keyWindow addSubview:guidePage];
    }
    

}

- (void)webViewLoadRequest {
    
#if kOnLine
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.baseUrlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
//    [_webView loadRequest:request];
    
#else
//    self.baseUrlString = AppBaseUrl;
    NSString *url = @"http://ceshi.mr-bango.cn/html-src/dist/";
//    NSString *url = @"https://mr-bango.cn/html-src/dist/";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [_webView loadRequest:request];
    
#endif
}



-(void)LoginWeChatCallback:(WVJBResponseCallback)responseCallback{
    
}

// JS吊起原生登录
- (void)startLogin:(WVJBResponseCallback)responseCallback {
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigationVC animated:YES completion:nil];
    
    [loginVC setLoginCallback:^(NSDictionary * _Nonnull userInfo) {
        responseCallback(userInfo);
    }];
    
}

#pragma mark ====分享朋友圈====
//-(void)shareParamResponseCallback:(WVJBResponseCallback)responseCallback{
//}


#pragma mark - loginSuccessNotifacation


#pragma mark - setter && getter

- (WKWebView *)webView {
    if (!_webView) {
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"LoginWeChatCallback:"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"LoginWeChatCallback"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"getBlogNameFromObjC"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"jumpToShare"];
        
        /*
         禁止长按(超链接、图片、文本...)弹出效果
         document.documentElement.style.webkitTouchCallout='none';
         去除长按后出现的文本选取框
         document.documentElement.style.webkitUserSelect='none'; */
        NSString *jsString = @"document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';";
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = wkUController;
        [config.userContentController addUserScript:noneSelectScript];
        
        //CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HomeIndicatorHeight)
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-HomeIndicatorHeight) configuration:config];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.allowsLinkPreview = NO;
    }
    return _webView;
}

/**
 0:无参数 无回调
 1:有参数
 2:有回调
 3:有参数 有回调
 */

- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WKWebViewJavascriptBridge enableLogging];
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        //        @weakify(self);
        [self.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
            //接收JS传参data，根据参数调用OC方法，完成后执行回调(可选)
            
            
            
            NSDictionary *dict =(NSDictionary *)data;
            if ([dict isKindOfClass:[NSDictionary class]]) {
                id array = dict[@"param"];
                NSString *selectorStr = dict[@"type"];
                NSLog(@"array = %@",array);
                NSLog(@"selectorStr = %@",selectorStr);
                WVJBResponseCallback response = ^(id results){
                    responseCallback(results);
                };
                if (!ObjectIsEmpty(array)&&[selectorStr isEqualToString:@"realNameAuthenticationParam:"]) {
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    id (*func)(id, SEL, WVJBResponseCallback) = (void *)imp;
                    func(self, selector,response);
                }else if ([selectorStr isEqualToString:@"realNameAuthenticationParam:"]){
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                    void (*func)(id,SEL,NSArray *) = (void *)imp;
                    func(self,selector,array);
                }else if ([selectorStr isEqualToString:@"savePictureParamParam:"]){
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                    void (*func)(id,SEL,NSArray *) = (void *)imp;
                    func(self,selector,array);
                    
                }else if ([selectorStr isEqualToString:@"startLogin:"]){
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    void (*func)(id,SEL,WVJBResponseCallback) = (void *)imp;
                    func(self,selector,response);
                    
                }else{
                    
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    id (*func)(id, SEL,id,WVJBResponseCallback) = (void *)imp;
                    func(self, selector,array,response);
                }
            }else{
                NSDictionary *results = @{@"status":@"0",
                                          @"msg":@"操作失败"
                                          };
                if (responseCallback) {
                    // 反馈给JS
                    /**
                     js调用网页里面的getBlogNameFromObjC方法。OC通过responseCallback数据回调传给js完成数据更新
                     这里面我们点击js里面的点击事件，然后到OC里面逛了一圈，在回调里面给一个
                     */
                    responseCallback(results);
                }
            }
        }];
    }
    return _bridge;
}


- (void)bridgeCallHandler:(NSString *)handleName data:(id)data {
    [self.bridge callHandler:handleName data:data responseCallback:^(id responseData) {
    }];
    
}
#pragma mark - JS 调用原生

#pragma mark ====复制==== unused
-(void)copyParam:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback{
    NSString *str = parm[0];
    if ([self copyText:str]) {
        if (responseCallback) {
            NSDictionary *dict = @{@"status":@"1",
                                   @"data"  :@{@"value":str},
                                   @"msg"    :@"操作成功"
                                   };
            responseCallback(dict);
        }
    }
}
-(BOOL)copyText:(NSString *)text{
    if ([NSString isNOTNull:text]) {
        [WXZTipView showCenterWithText:@"复制失败" duration:3];
        return NO;
    }
    [WXZTipView showCenterWithText:@"复制成功"  duration:3];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
    return  YES;
}
#pragma mark ====获取版本号====
-(void)getVersionNumberResponseCallback:(WVJBResponseCallback)responseCallback {
    if (responseCallback) {
        NSDictionary *dict = @{@"status":@"1",
                               @"data"  :@{@"value":AppVersion},
                               @"msg"    :@"操作成功"
                               };
        responseCallback(dict);
    }
}

#pragma mark ====分享朋友圈====

/** app推广分享 */
-(void)shareParams:(NSDictionary *)params ResponseCallback:(WVJBResponseCallback)responseCallback {
    if (DictIsEmpty(params)) return;
    [ShareObject.sharedObject appShareWithParams:params];
}

/** 拼团的分享 */
-(void)shareURLAuthenticationParam:(NSArray *)parm {
    NSDictionary *parms = parm[0];
    if (DictIsEmpty(parms)) return;
    
    [ShareObject.sharedObject groupShareWithText:parms[@"description"] images:parms[@"imgSrc"] url:parms[@"shareAddress"] title:parms[@"title"]];
}

#pragma mark ====实名认证====
-(void)realNameAuthenticationParam:(NSArray *)parm{
    NSString *str = parm[0];
    RealNameAuthenticationVC *real = [[RealNameAuthenticationVC alloc]init];
    real.token = str;
    [self.navigationController pushViewController:real animated:YES];
}

-(void)savePictureParamParam:(NSArray *)parm{
    NSString *imageUrl = parm[0];
    if (![NSString isNOTNull:imageUrl]) {
        // 保存图片到相册中
        UIImageWriteToSavedPhotosAlbum([self imageWithScreenshot],self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }else{
        [WXZTipView showCenterWithText:@"图片保存失败"];
    }
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    [self hideBubble];
    // Was there an error?
    if (error != NULL)
    {
        [WXZTipView showCenterWithText:@"图片保存失败"];
    }
    else  // No errors
    {
        [WXZTipView showCenterWithText:@"图片保存成功"];
    }
}

#pragma mark ====保存图片到本地====
-(void)saveScreenCallback:(WVJBResponseCallback)responseCallback{
    UIImageWriteToSavedPhotosAlbum([self captureScrollView:self.webView.scrollView],self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}
#pragma mark ====清除缓存==== unused
-(void)clearWebViewCacheCallback:(WVJBResponseCallback)responseCallback{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];[cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

#pragma mark ====微信支付====
-(void)weChatPay:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback {
    if (parm.count==0) {
        [WXZTipView showCenterWithText:@"参数错误"];
        return;
    }
    [PaymentDelegateManager.sharedPaymentManager wechatPayWithParams:@{@"order_id":[NSString stringWithFormat:@"%@",parm[0]]} finish:^(int respCode) {
        
        BOOL isPaySucceed = YES;
        switch (respCode) {
            case WXSuccess:
            {
                isPaySucceed = YES;
                // 支付成功
                [WXZTipView showCenterWithText:@"支付成功"];
            }
                break;
                
            case WXErrCodeUserCancel:
            {
                isPaySucceed = NO;
                // 取消支付
                [WXZTipView showCenterWithText:@"用户取消支付"];
            }
                break;
                
            default:
            {
                isPaySucceed = NO;
                // 支付失败
                [WXZTipView showCenterWithText:@"支付失败"];
            }
                break;
        }
        if (responseCallback) {
            NSDictionary *dict = @{@"status":isPaySucceed?@"1":@"0",
                                   @"data"  :@{},
                                   @"msg"    :@"操作成功"
                                   };
            responseCallback(dict);
        }
    }];
}


#pragma mark ====支付宝支付====
-(void)alipayPayment:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback{
    NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay://"];
    if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        [WXZTipView showCenterWithText:@"检测到您的手机没有支付宝软件，暂无法支付"];
        return;
    }
    if (parm.count==0||parm == nil) {
        [WXZTipView showCenterWithText:@"暂无获取订单相关内容，暂无法支付"];
        return;
    }
    
   [PaymentDelegateManager.sharedPaymentManager alipayPaycompleteParams:@{@"orderid":[NSString stringWithFormat:@"%@",parm[0]]} payFinish:^(int code) {
        BOOL isPaySucceed = YES;
        
        switch (code) {
            case 9000:
            {
                isPaySucceed = YES;
                // 支付成功
                [WXZTipView showCenterWithText:@"支付成功"];
            }
                break;
                
            case 8000:
            {
                isPaySucceed = NO;
                // 取消支付
                [WXZTipView showCenterWithText:@"支付正在处理"];
            }
                break;
            case 4000:
            {
                isPaySucceed = NO;
                // 取消支付
                [WXZTipView showCenterWithText:@"订单支付失败"];
            }
                break;
            case 6001:
            {
                isPaySucceed = NO;
                // 取消支付
                [WXZTipView showCenterWithText:@"取消支付"];
            }
                break;
            case 6002:
            {
                isPaySucceed = NO;
                // 取消支付
                [WXZTipView showCenterWithText:@"网络连接出错"];
            }
                break;
                
            default:
            {
                isPaySucceed = NO;
                // 支付失败
                [WXZTipView showCenterWithText:@"支付失败"];
            }
                break;
        }
        if (responseCallback) {
            NSDictionary *dict = @{@"status":isPaySucceed?@"1":@"0",
                                   @"data"  :@{},
                                   @"msg"    :@"操作成功"
                                   };
            responseCallback(dict);
        }
    }];
}

-(void)detectionUpdateResponseCallback:(WVJBResponseCallback)responseCallback{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本是：%@",app_Version);
}


#pragma mark ====返回首页==== unused
-(void)goHomeCallback:(WVJBResponseCallback)responseCallback{
    // 获取本地资源路径
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
    // 通过路径创建本地URL地址
    NSURL *url = [NSURL fileURLWithPath:pathStr];
    //     NSURL *url = [NSURL URLWithString:@"http://192.168.0.220:8085/login"];
    // 创建请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    // 通过webView加载请求
    [self.webView loadRequest:request];
    
}


- (UIImage *)captureScrollView:(UIScrollView *)scrollView {
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, NO, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.frame = CGRectMake(0 , 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}
@end
