//
//  WB_Request.m
//  WB_iOS_FrameWork
//
//  Created by weibo on 2017/9/26.
//  Copyright © 2017年 WWB_iOS. All rights reserved.
//

#import "WB_Request.h"
//#import "SFHFKeychainUtils.h"
@implementation WB_Request
-(id)initWithParameter:(NSDictionary *)parameter{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(id)init{
    self = [super init];
    if (self) {
        self.animatingText = @"正在加载";
    }
    return self;
}
-(NSInteger)getCodeStatus{
    NSString *code = [[self responseJSONObject] objectForKey:@"status"];
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
#pragma mark 添加请求头
//-(NSDictionary *)requestHeaderFieldValueDictionary
//{
//    NSMutableDictionary *headParams=[[NSMutableDictionary alloc]init];
//
//    [headParams setObject:MMNSStringFormat(@"%@",[SFHFKeychainUtils GetIOSUUID]) forKey:@"device"];
//    return headParams;
//   
//}

#pragma mark 请求方式
- (YTKRequestMethod)requestMethod {
    //    if (GETORPOST == 1) {
    //        return YTKRequestMethodPOST;
    //    }else{
    //        return YTKRequestMethodGET;
    //    }
    return YTKRequestMethodPOST;
}
@end
