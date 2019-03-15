//
//  ZCWebViewController.m
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCWebViewController.h"
#import <WebKit/WebKit.h>
//#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import "WeakWebViewScriptMessageDelegate.h"
#import "ScriptMessageHandler.h"
#import "DHGuidePageHUD.h"

#import "ZCBaseNavigationController.h"
#import "ZCLoginViewController.h"
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
//    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:@[@"guide_1",@"guide_2",@"guide_3"] buttonIsHidden:NO];
//    [[UIApplication sharedApplication].keyWindow addSubview:guidePage];

}

- (void)webViewLoadRequest {
    
#if kOnLine
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.baseUrlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
//    [_webView loadRequest:request];
    
#else
//    self.baseUrlString = AppBaseUrl;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://mr-bango.cn/html-src/dist/"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [_webView loadRequest:request];
    
#endif
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary * parameter = message.body;
    if([message.name isEqualToString:@"jumpToShareInterface"]){
    }
    
}

-(void)LoginWeChatCallback:(WVJBResponseCallback)responseCallback{
    
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigationVC animated:YES completion:nil];
    
}

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
        
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:config];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.allowsLinkPreview = NO;
        
    }
    return _webView;
}



- (WKWebViewJavascriptBridge *)bridge {
    if (!_bridge) {
        [WKWebViewJavascriptBridge enableLogging];
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        [self.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
            //接收JS传参data，根据参数调用OC方法，完成后执行回调(可选)
            NSDictionary *dict =(NSDictionary *)data;
            if ([dict isKindOfClass:[NSDictionary class]]) {
                NSArray *array = dict[@"param"];
                NSString *selectorStr = dict[@"type"];
                NSLog(@"array = %@",array);
                NSLog(@"selectorStr = %@",selectorStr);
                WVJBResponseCallback response = ^(id results){
                    responseCallback(results);
                };
                if (array.count == 0&&![selectorStr isEqualToString:@"realNameAuthenticationParam:"]) {
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
                }else{
                    
                    SEL selector = NSSelectorFromString(selectorStr);
                    IMP imp = [self methodForSelector:selector];
                    id (*func)(id, SEL,NSArray *,WVJBResponseCallback) = (void *)imp;
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




@end
