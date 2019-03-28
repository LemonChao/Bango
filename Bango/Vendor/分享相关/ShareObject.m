//
//  ShareObject.m
//  Bango
//
//  Created by zchao on 2019/3/16.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ShareObject.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDK/ShareSDK.h>
#import "FaceShareView.h"
@implementation ShareObject

+ (ShareObject *)sharedObject {
    static ShareObject *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[ShareObject alloc]init];
    });
    return handler;
}

/** app推广分享，个人中心分享 */
- (void)appShareWithParams:(NSDictionary *)params {
    self.appShareInfo = params;
    // type(1:扫一扫2:微信好友3:微信朋友圈)
    NSString *urlStr = [params[@"shareAddress"] stringByAppendingString:@"&type=2"];;
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:params[@"descript"]
                                     images:params[@"logo"]
                                        url:[NSURL URLWithString:urlStr]
                                      title:params[@"title"]
                                       type:SSDKContentTypeAuto];
    
    SSUIPlatformItem *faceItem = [[SSUIPlatformItem alloc] init];
    faceItem.platformName = @"面对面";
    faceItem.iconNormal = [UIImage imageNamed:@"sns_icon_500"];
    faceItem.iconSimple = [UIImage imageNamed:@"sns_icon_500"];
    faceItem.platformId = @"sns_icon_500";
    [faceItem addTarget:self action:@selector(faceShareItemAction:)];
    
    NSArray *items = @[@(SSDKPlatformSubTypeWechatSession),
                       @(SSDKPlatformSubTypeWechatTimeline),
                       faceItem];
    
    SSUIShareSheetConfiguration *config = [[SSUIShareSheetConfiguration alloc] init];
    config.style = SSUIActionSheetStyleSystem;
    config.columnPortraitCount = 3;
    config.menuBackgroundColor = [UIColor whiteColor];
    config.cancelButtonHidden = YES;
    config.itemTitleFont = MediumFont(WidthRatio(12));
    config.itemTitleColor = MinorColor;
    
    [ShareSDK showShareActionSheet:nil
                       customItems:items
                       shareParams:shareParams
                sheetConfiguration:config
                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
     {
         switch (state) {
                 
             case SSDKResponseStateSuccess:
                 break;
             case SSDKResponseStateFail:
             {
                 NSLog(@"--%@",error.description);
                 //失败
                 break;
             }
             case SSDKResponseStateCancel:
                 break;
             default:
                 break;
         }
     }];
}



- (void)groupShareWithText:(NSString *)text images:(id)images url:(NSURL *)url title:(NSString *)title {
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:images
                                        url:url
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    NSArray *items = @[@(SSDKPlatformSubTypeWechatSession),
                       @(SSDKPlatformSubTypeWechatTimeline),
                       @(SSDKPlatformTypeQQ),
                       @(SSDKPlatformSubTypeQZone)];
    
    [ShareSDK showShareActionSheet:nil
                       customItems:items
                       shareParams:shareParams
                sheetConfiguration:nil
                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
     {
         switch (state) {
                 
             case SSDKResponseStateSuccess:
                 break;
             case SSDKResponseStateFail:
             {
                 NSLog(@"--%@",error.description);
                 //失败
                 break;
             }
             case SSDKResponseStateCancel:
                 break;
             default:
                 break;
         }
     }];
    
}
- (void)faceShareItemAction:(SSUIPlatformItem *)item {
    UIWindow *kWindow = [UIApplication sharedApplication].keyWindow;
    FaceShareView *faceView = [[FaceShareView alloc] initWithInfo:self.appShareInfo];
    
    [kWindow addSubview:faceView];

}


/** 游戏的无分享面板分享 */
- (void)shareImmediatelyWithParams:(NSDictionary *)params {
    NSLog(@"params:%@", params);
    if (![params containsObjectForKey:@"platform"]) return;
    
    SSDKPlatformType platform;
    if ([params[@"platform"] isEqualToString:@"WechatSession"]) {
        platform = SSDKPlatformSubTypeWechatSession;
    }
    else if ([params[@"platform"] isEqualToString:@"WechatTimeline"]){
        platform = SSDKPlatformSubTypeWechatTimeline;
    }
    else if ([params[@"platform"] isEqualToString:@"QZone"]){
        platform = SSDKPlatformSubTypeQZone;
    }
    else if ([params[@"platform"] isEqualToString:@"QQFriend"]){
        platform = SSDKPlatformTypeQQ;
    }else return;

    //1、创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:params[@"text"]
                                     images:params[@"images"] ? params[@"images"] :@[AppIconUrl]
                                        url:params[@"url"]
                                      title:params[@"title"]
                                       type:SSDKContentTypeImage];
    
    //进行分享
    [ShareSDK share:platform parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         switch (state) {
             case SSDKResponseStateFail:
             {
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享失败" message:[error localizedDescription] preferredStyle:(UIAlertControllerStyleAlert)];
                 [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil]];
                 [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                 
                 NSLog(@"error:%@", error);
             }
             break;
             
             default:
             break;
         }
     }];
}


@end
