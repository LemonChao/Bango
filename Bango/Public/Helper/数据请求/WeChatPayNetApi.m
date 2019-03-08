//
//  WeChatPayNetApi.m
//  GCT
//
//  Created by 张海彬 on 2018/12/27.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "WeChatPayNetApi.h"

@implementation WeChatPayNetApi
{
    NSDictionary *_parameter;
}
-(id)initWithParameter:(NSDictionary *)parameter{
    self = [super initWithParameter:parameter];
    if (self) {
        _parameter = parameter;
    }
    return self;
}
    //###########接口地址#########
-(NSString *)requestUrl
{
    return @"paywx/wx_pay";
}
    //#########传参#############
-(id)requestArgument{
    return _parameter;
}
-(id)getContent{
     return  [[self responseJSONObject] objectForKey:@"info"];
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
