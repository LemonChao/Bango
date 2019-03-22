//
//  ShareObject.m
//  Bango
//
//  Created by zchao on 2019/3/16.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ShareObject.h"
#import <ShareSDKUI/ShareSDKUI.h>
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



- (void)asdfdsaf {
    //      直接分享
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //
    //    [params SSDKSetupShareParamsByText:@"test" images:[UIImage imageNamed:@"login_phone"] url:[NSURL URLWithString:@"http://www.mob.com/"] title:@"title" type:SSDKContentTypeAuto];
    //
    //    [ShareSDK share:SSDKPlatformTypeWechat parameters:params onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
    //
    //        switch (state) {
    //            case SSDKResponseStateUpload:
    //                // 分享视频的时候上传回调，进度信息在 userData
    //                break;
    //            case SSDKResponseStateSuccess:
    //                //成功
    //                break;
    //            case SSDKResponseStateFail:
    //            {
    //                NSLog(@"--%@",error.description);
    //                //失败
    //                break;
    //            }
    //            case SSDKResponseStateCancel:
    //                //取消
    //                break;
    //
    //            default:
    //                break;
    //        }
    //    }];
}


@end
