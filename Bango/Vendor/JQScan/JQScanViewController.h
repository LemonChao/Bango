//
//  JQScanViewController.h
//
//   
//  Created by 韩俊强 on 15/10/21.
//  Copyright © 2015年 韩俊强. All rights reserved.
//

#import "JQScanViewController.h"
#import "JQZXScanViewController.h"

@interface JQScanViewController : JQZXScanViewController

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;
/** 结果回调*/
@property (nonatomic,copy) void (^resultsCallback)(JQScanResult *strResult);
@end
