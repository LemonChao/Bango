//
//  WB_NetApiConstant.m
//  WB_iOS_FrameWork
//
//  Created by weibo on 2017/9/26.
//  Copyright © 2017年 WWB_iOS. All rights reserved.
//

#import "WB_NetApiConstant.h"

#import "YTKNetworkConfig.h"

#import "YTKNetworkAgent.h"

//#define GDP_BASEURL  @"http://bgj.zhongchangjy.com/index.php/?s=/wap/"
#define GDP_BASEURL  @"https://mr-bango.cn/index.php/?s=/wap/"
@implementation WB_NetApiConstant
static WB_NetApiConstant *Const = nil;
+ (WB_NetApiConstant *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        Const = [[self alloc] init];
        
    });
    return Const;
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        
        YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
        
        [agent setValue:[NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/html", nil]
             forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];
        
        YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
        //请求的基础url前缀
        config.baseUrl = GDP_BASEURL;
        
//        YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//        [config setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html",@"text/css", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];

        //请求的基础url前缀
//        config.baseUrl = TFC_BASEURL;
//        //图片上传url前缀
//        _imageUpLoadPrefix = TFC_BASEURL;
    }
    return self;
}


@end
