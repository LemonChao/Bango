//
//  ZCWebViewController.m
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCWebViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import "WeakWebViewScriptMessageDelegate.h"
#import "ScriptMessageHandler.h"

@interface ZCWebViewController ()<WKScriptMessageHandler,WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;


@end

@implementation ZCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self webViewLoadRequest];
}

- (void)configViews {
    [self.view addSubview:self.webView];
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
        
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = wkUController;
        
        NSMutableString *javascript = [NSMutableString string];
        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary * parameter = message.body;
    if([message.name isEqualToString:@"jumpToShareInterface"]){
    }

}
@end
