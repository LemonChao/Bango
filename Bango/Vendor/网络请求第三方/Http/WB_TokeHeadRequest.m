//
//  WB_TokeHeadRequest.m
//  GDP
//
//  Created by 张海彬 on 2018/8/8.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "WB_TokeHeadRequest.h"
//#import "JSONKit.h"
#import "SFHFKeychainUtils.h"
@implementation WB_TokeHeadRequest
-(id)init{
    self = [super init];
    if (self) {
        self.animatingText = @"正在加载";
    }
    return self;
}
-(NSInteger)getCodeStatus{
    NSString *code = [[self responseJSONObject] objectForKey:@"status"];
    if ([code integerValue] == -1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
    }
    return [code integerValue];
}
-(NSString * )getMsg
{
    return [[self responseJSONObject] objectForKey:@"msg"];
}
-(id)getContent
{
    return  [[self responseJSONObject] objectForKey:@"data"];
}

#pragma mark 请求方式
- (YTKRequestMethod)requestMethod {
    //    if (GETORPOST == 1) {
    //        return YTKRequestMethodPOST;
    //    }else{
    //        return YTKRequestMethodGET;
    //    }
    return YTKRequestMethodPOST;
}
#pragma mark 添加请求头
-(NSDictionary *)requestHeaderFieldValueDictionary
{
    NSMutableDictionary *headParams=[[NSMutableDictionary alloc]init];
    //    [headParams setObject:@"31" forKey:@"accountId"];
    //    [headParams setObject:@"2" forKey:@"isUser"];
    if ([self addToken:headParams]) {
        return headParams;
    }else{
        //停止请求
        [self stop];
        return nil;
    }
}

//- (NSURLRequest *)buildCustomUrlRequest {
//    NSURLRequest *request = [super buildCustomUrlRequest];
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    [mutableRequest addValue:@"123123" forHTTPHeaderField:@"Authorization"];
//    request = [mutableRequest copy];
//    return request;
//}
-(BOOL)addToken:(NSMutableDictionary *)headParams{
//    if (![NSString isNOTNull: [HeaderToken getAccessToken]]) {
//        //添加token 例如：
//        [headParams setObject:MMNSStringFormat(@"Bearer %@",[HeaderToken getAccessToken]) forKey:@"A-uthorization"];
//        return YES;
//    }else if (![NSString isNOTNull: [HeaderToken getRefreshToken]]){
//        //这里写更新token的请求
//        NSString *token = [WB_TokeHeadRequest getRefreshToke];
//        if (![NSString isNOTNull:token]) {
//            [headParams setObject:MMNSStringFormat(@"Bearer %@",[HeaderToken getAccessToken]) forKey:@"A-uthorization"];
//            return YES;
//        }else{
//             [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
//            return NO;
//        }
//    }
    if (![NSString isNOTNull: [HeaderToken getAccessToken]]) {
        //添加token 例如：
        [headParams setObject:[NSString stringWithFormat:@"%@", [HeaderToken getAccessToken]] forKey:@"token"];
        [headParams setObject:[NSString stringWithFormat:@"%@", [SFHFKeychainUtils GetIOSUUID]] forKey:@"device"];

        return YES;
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
    return NO;
}
#pragma mark ====当refresh_token没有过期的时候调用，刷新access_token======
+(id)getRefreshToke{
    //    post请求参数不在地址后拼接GET_SD_TOKE
    NSURL *url = [NSURL URLWithString:@""];
    //    因为要往请求数据区添加参数，所以要创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //GET请求中的请求参数（每个公司都不一样）
    NSString *paramterStr = [NSString stringWithFormat:@"refresh_token=%@",[HeaderToken getRefreshToken]];
    //    字符串转data
    NSData *data = [paramterStr dataUsingEncoding:NSUnicodeStringEncoding];
    //    设置请求数据（请求包体）
    [request setHTTPBody:data];
    //    设置请求方法
    [request setHTTPMethod:@"post"];
    //    设置超时时间
    [request setTimeoutInterval:20];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    这是个异步请求
    //    [NSURLConnection connectionWithRequest:request delegate:self];
    //    同步请求
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *Str = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"====%@",Str);
    if (responseData != nil) {
        NSDictionary *dict =  [self handleResponseObject:responseData];
        NSDictionary *dataDict = dict[@"info"];
        if ([dataDict isKindOfClass:[NSDictionary class]]) {
            /**这些取得参数名是和后台一起定义的，可以修改*/
            NSString *expires =[NSString stringWithFormat:@"%@",dataDict[@"expires"]] ;
            NSString *refreshTokenExpires = [NSString stringWithFormat:@"%@",dataDict[@"refreshTokenExpires"]];
            NSString *refresh_token =[NSString stringWithFormat:@"%@",dataDict[@"refresh_token"]];
            NSString *access_token = dataDict[@"access_token"];
            [HeaderToken setToken:access_token];
            [HeaderToken setExpires:expires];
            [HeaderToken setRefreshToken:refresh_token];
            [HeaderToken setRefreshTokenExpires:refreshTokenExpires];
            return access_token;
        }else{
            return nil;
        }
        
    }else{
        return nil;
    }
    
}
#pragma mark ====数据处理====
+ (id)handleResponseObject:(NSData *)data {
    
    //将获取的二进制数据转成字符串
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    id object = [str objectFromJSONString];
//
//    return object;
    
//    id object = [str objectFromJSONString];
    
    return str;

}
@end
