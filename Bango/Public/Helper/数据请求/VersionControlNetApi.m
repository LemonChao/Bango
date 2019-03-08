//
//  VersionControlNetApi.m
//  GCT
//
//  Created by 张海彬 on 2018/8/25.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "VersionControlNetApi.h"

@implementation VersionControlNetApi
-(id)init{
    self = [super init];
    if (self) {
        self.isHiddenLoading = YES;
    }
    return self;
}
//###########接口地址#########
-(NSString *)requestUrl
{
     return @"Index/version";
    
}
//#########传参#############
-(id)requestArgument
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return @{
             @"appname": app_Name,
             @"type": @"2",
             @"version":app_Version
             };
}
#pragma mark 请求方式
- (YTKRequestMethod)requestMethod {
        //    if (GETORPOST == 1) {
    return YTKRequestMethodPOST;
        //    }else{
        //        return YTKRequestMethodGET;
        //    }
}
@end
