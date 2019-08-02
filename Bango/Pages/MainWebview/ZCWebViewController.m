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
#import "CommonTools.h"
#import "SELUpdateAlert.h"
#import <AFURLResponseSerialization.h>


@interface ZCWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate, WKUIDelegate>
{
    SELUpdateAlert *updateAlert;
    
}

@property (strong, nonatomic) WKWebView *webView;

@property (strong, nonatomic) WKWebViewJavascriptBridge *bridge;

@end

@implementation ZCWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.topInset = StatusBarHeight;
        self.bottomInset = HomeIndicatorHeight;
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path parameters:(nullable NSDictionary *)parameters
{
    self = [super init];
    if (self) {
        self.topInset = StatusBarHeight;
        self.bottomInset = HomeIndicatorHeight;
        self.pathForH5 = path;
        self.parameters = parameters?:@{};//
        if ([path isEqualToString:@"GuoGuoGame"] || [path isEqualToString:@"FruitTreeGame"]) {
            self.urlString = StringFormat(@"%@/%@?%@",AppBaseUrl,self.pathForH5,AFQueryStringFromParameters(self.parameters));
        }else {
            self.urlString = StringFormat(@"%@html-src/dist/#/%@?%@",AppBaseUrl,self.pathForH5,AFQueryStringFromParameters(self.parameters));
        }
//        if ([path isEqualToString:@"GuoGuoGame"]) {
//            self.urlString = StringFormat(@"%@/%@?%@",AppBaseUrl,self.pathForH5,AFQueryStringFromParameters(self.parameters));
//        }else {
//            self.urlString = StringFormat(@"%@/#/%@?%@",@"http://192.168.0.190:10002",self.pathForH5,AFQueryStringFromParameters(self.parameters));
//        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self webViewLoadRequest];
    [self.bridge setWebViewDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)configViews {
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(self.topInset, 0, self.bottomInset, 0));
    }];
}

//控制StatusBar是否隐藏
- (BOOL)prefersStatusBarHidden
{
    if ([self.pathForH5 isEqualToString:@"GuoGuoGame"]) {
        return YES;
    }
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self.pathForH5 isEqualToString:@"GuoGuoGame"]) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}


- (void)webViewLoadRequest {
//    NSString *url = @"https://mr-bango.cn/html-src/dist/";@"http://192.168.0.177:10001/#/goods-detail?goods_id=12"

//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[AppBaseUrl stringByAppendingString:@"html-src/dist/"]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
//    NSString *urlString = StringFormat(@"%@%@",AppBaseUrl,AFQueryStringFromParameters(self.parameters));

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];

    [self.webView loadRequest:request];
}

-(void)versionUpdateRequest{
    
    NSDictionary *params = @{@"appname":@"搬果将",
                             @"type": @"2",
                             @"version":AppVersion};
    
    [NetWorkManager.sharedManager requestWithUrl:kIndex_version withParameters:params withRequestType:POSTTYPE withSuccess:^(id  _Nonnull responseObject) {
        NSDictionary *data = responseObject[@"data"];
        if (!DictIsEmpty(data)) {
            [self setUpVersion:data];
        }else {
            if (self->updateAlert) {
                [self->updateAlert removeFromSuperview];
            }
        }
    } withFailure:^(NSError * _Nonnull error) {
        kShowError
    }];
    
}

// JS吊起原生登录
- (void)startLogin:(WVJBResponseCallback)responseCallback {
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    ZCBaseNavigationController *navigationVC = [[ZCBaseNavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:navigationVC animated:YES completion:nil];
    
    [loginVC setLoginCallback:^(NSDictionary * _Nonnull userInfo) {
        responseCallback(userInfo);
    }];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //JS调用OC方法
    //message.boby就是JS里传过来的参数
    NSLog(@"body:%@",message.body);
    
    NSDictionary * parameter = message.body;
    if ([message.name isEqualToString:gameShareImmediately]) { //立即分享
        [ShareObject.sharedObject shareImmediatelyWithParams:parameter];
    }else if ([message.name isEqualToString:@"GoToHome"]) {//返回原生
        [self goToHome:message.body];
    }else if ([message.name isEqualToString:@"logout"]) {//退出登陆
        [self logoutApp];
    }

}

#pragma mark - 返回首页--
-(void)goToHome:(NSString *)level{
    NSLog(@"count:%lu == %@",(unsigned long)self.webView.backForwardList.backList.count, self.webView.backForwardList.backList);
    for (WKBackForwardListItem *item in self.webView.backForwardList.backList) {
        NSLog(@"backUrl:%@", item.URL);
    }
    
    if (StringIsEmpty(level) || level.integerValue == 0) {
        UINavigationController *rootNav =  (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
        UITabBarController *tabBarVC = (UITabBarController *)rootNav.topViewController;
        UINavigationController *nav = tabBarVC.selectedViewController;
        [nav popToRootViewControllerAnimated:NO];
        [tabBarVC setSelectedIndex:0];
        return;
    }
    
    if (self.webView.backForwardList.backList.count <= 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.webView goBack];
    }
}
- (void)logoutApp {
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    info.asstoken = nil;
    [BaseMethod saveObject:info withKey:UserInfo_UDSKEY];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - setter && getter

- (WKWebView *)webView {
    if (!_webView) {
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:gameShareImmediately];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"GoToHome"];
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"logout"];

        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = wkUController;

//    preferences.minimumFontSize = 40.0;
        config.preferences = preferences;
        NSMutableDictionary *dic = [NSMutableDictionary new];
        UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
        if (info.asstoken) {
            dic = info.userResp;
       }else {
            dic[@"asstoken"] = @"";
            dic[@"login_num"] = @"";
            dic[@"login_type"] = @"";
            dic[@"tx_pwd_status"] = @"";
            dic[@"user_headimg"] = @"";
            dic[@"user_tel"] = @"";
        }
        NSLog(@"window.iOSInfo:%@", dic);
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
        [config.userContentController addUserScript:script];
        /*
         禁止长按(超链接、图片、文本...)弹出效果
         document.documentElement.style.webkitTouchCallout='none';
         去除长按后出现的文本选取框
         document.documentElement.style.webkitUserSelect='none'; */
        NSString *jsString = @"document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';";
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:noneSelectScript];
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            [self setAutomaticallyAdjustsScrollViewInsets:NO];
        }
        self.navigationController.edgesForExtendedLayout = UIRectEdgeTop;
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
                if (ObjectIsEmpty(array)) {
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


#pragma mark - WKUIDelegate && NavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // ------  对scheme:相关的scheme处理 -------
    // 若遇到微信、支付宝、QQ等相关scheme，则跳转到本地App
    NSString *scheme = navigationAction.request.URL.scheme;

    // 判断scheme是否是 http或者https，并返回BOOL的值
    BOOL urlOpen = [scheme isEqualToString:@"https"] || [scheme isEqualToString:@"http"];

    if (!urlOpen) {
        // 跳转相关客户端
        BOOL bSucc = [[UIApplication sharedApplication]openURL:navigationAction.request.URL];

        // 如果跳转失败，则弹窗提示客户
        if (!bSucc) {
            // 设置弹窗
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到该客户端，请您安装后重试。" preferredStyle:UIAlertControllerStyleAlert];
            // 确定按键不带点击事件
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    // 确认可以跳转，必须实现该方法，不实现会报错
    decisionHandler(WKNavigationActionPolicyAllow);
}


//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
//    //    DLOG(@"msg = %@ frmae = %@",message,frame);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }])];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.text = defaultText;
//    }];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(alertController.textFields[0].text?:@"");
//    }])];
//    
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}

#pragma mark - 原生调用JS

- (void)bridgeCallHandler:(NSString *)handleName data:(id)data {
    [self.bridge callHandler:handleName data:data responseCallback:^(id responseData) {
    }];
    
}


#pragma mark JS 调用原生 unused
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
                               @"data"  :@{@"value":[NSString stringWithFormat:@"%@", AppVersion]},
                               @"msg"   :@"操作成功"
                               };
        responseCallback(dict);
    }
}

#pragma mark ====分享朋友圈====

/** app推广分享 */
-(void)shareParams:(NSDictionary *)params ResponseCallback:(WVJBResponseCallback)responseCallback {
//    if (DictIsEmpty(params)) return;
//    [ShareObject.sharedObject appShareWithParams:params];
}

/** 拼团的分享 */
-(void)shareURLAuthenticationParam:(NSArray *)parm {
    if (![parm[0] isKindOfClass:[NSDictionary class]]) return;
    
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

//版本设置
-(void)setUpVersion:(NSDictionary *)dataDict{
    if (dataDict != nil) {
        NSString *description = dataDict[@"remark"];
        if (![NSString isNOTNull:description]) {
            [CommonTools setUpdateDescription:description];
        }else{
            [CommonTools setUpdateDescription:@"有新版版本需要更新"];
        }
        BOOL isForce = [dataDict[@"force_update"] boolValue];
        [CommonTools setIsForce:isForce];
        BOOL hasNewVersion = [dataDict[@"is_update"] boolValue];
        [CommonTools setIsHasNewVersion:hasNewVersion];
        NSString *version = [NSString stringWithFormat:@"%@",dataDict[@"ver_nod"]];
        [CommonTools setVersionString:version];
        if (![NSString isNOTNull:[NSString stringWithFormat:@"%@",dataDict[@"url"]]]) {
            [CommonTools setUpdateVersionAddress:[NSString stringWithFormat:@"%@",dataDict[@"url"]]];
        }
        if (hasNewVersion) {
            if (updateAlert == nil) {
                [self VersionBounced];
            }
            
        }else{
            if (updateAlert != nil) {
                [updateAlert removeFromSuperview];
                updateAlert = nil;
            }
        }
        
    }
    
}
-(void)VersionBounced{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (![NSString isNOTNull:[CommonTools getVersionString]]&&![app_Version isEqualToString:[CommonTools getVersionString]]) {
        BOOL hasNewVersion = [CommonTools IsHasNewVersion];
        BOOL isForce =  [CommonTools IsForce];
        if (hasNewVersion) {
            if (isForce) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    self->updateAlert = [SELUpdateAlert showUpdateAlertWithVersion:[CommonTools getVersionString] Description:[CommonTools getUpdateDescription]];
                    self->updateAlert.isMandatory = YES;
                    [self->updateAlert setUpdateNow:^{
                        
                        NSString *versionAdd = [CommonTools getVersionAddress];
                        if (![NSString isNOTNull:versionAdd]) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionAdd]];
                        }else{
                            [WXZTipView showCenterWithText:@"更新地址错误"];
                        }
                    }];
                    
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    self->updateAlert = [SELUpdateAlert showUpdateAlertWithVersion:[CommonTools getVersionString] Description:[CommonTools getUpdateDescription]];
                    [self->updateAlert setUpdateNow:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[CommonTools getVersionAddress]]];
                    }];
                    [self->updateAlert setDismissBlock:^{
                        self->updateAlert = nil;
                    }];
                });

            }
        }
    }
    
}

- (void)checkAppVersion {
    [self versionUpdateRequest];
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

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

@end
