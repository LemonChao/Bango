//
//  ShareProductInfoView.h
//  HuoJianJiSong
//
//  Created by Apple on 2017/12/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface ShareProductInfoView : UIView
+(void)shareBtnClick:(SSDKPlatformType)shareType ShareImage:(UIImage *)shareImage shareBtnClickBlock:(void(^)(BOOL isSucceed,NSString *msg))shareBtnClickBlock;

+(void)shareBtnClick:(SSDKPlatformType)shareType
            ShareUrl:(NSString *)shareUrl
       ShareImageUrl:(NSString *)shareImageUrl
          ShareTitle:(NSString *)shareTitle
       ShareDescribe:(NSString *)describe
  shareBtnClickBlock:(void(^)(BOOL isSucceed,NSString *msg))shareBtnClickBlock;
@end
