//
//  FaceShareView.m
//  Bango
//
//  Created by zchao on 2019/3/19.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "FaceShareView.h"
#import "UserInfoModel.h"
#import <Photos/Photos.h>
#import "JQScanWrapper.h"

@interface FaceShareView()

@property(nonatomic, strong) UIImageView *qrImageView;

@end


@implementation FaceShareView


- (instancetype)initWithInfo:(NSDictionary *)shareInfo {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        UIButton *closeButton = [UITool imageButton:ImageNamed(@"face_invite_close")];
        [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *contentBgView = [UITool viewCornerRadius:WidthRatio(15)];
        UIImageView *avatar = [UITool imageViewImage:shareInfo[@"user_headimg"] placeHolder:nil contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(20) borderWidth:0.f borderColor:[UIColor clearColor]];
        avatar.backgroundColor = HEX_COLOR(0xD0F0FD);
        UIButton *saveButton = [UITool wordButton:@"保存图片" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:WidthRatio(14)] bgImage:ImageNamed(@"face_invite_savebg")];
        [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView *line = [UITool viewWithColor:LineColor];
        UILabel *nameLablel = [UITool labelWithText:shareInfo[@"nick_name"] textColor:PrimaryColor font:[UIFont boldSystemFontOfSize:WidthRatio(15)]];
        UIImageView *qrBgView = [UITool imageViewImage:ImageNamed(@"shaoyishao_box") contentMode:UIViewContentModeScaleAspectFill];
        UILabel *titleLab = [UITool labelWithText:@"面对面邀请" textColor:PrimaryColor font:BoldFont(WidthRatio(17)) alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor whiteColor]];
        NSString *urlString = [[shareInfo objectForKey:@"shareAddress"] stringByAppendingString:@"&type=1"];
        UIImage *qrImage = [JQScanWrapper createQRWithString:urlString size:CGSizeMake(SCREEN_WIDTH-WidthRatio(104), SCREEN_WIDTH-WidthRatio(104))];
        self.qrImageView = [UITool imageViewImage:qrImage contentMode:UIViewContentModeScaleToFill];
        
        
        [self addSubview:closeButton];
        [self addSubview:contentBgView];
        [contentBgView addSubview:avatar];
        [contentBgView addSubview:saveButton];
        [contentBgView addSubview:line];
        [contentBgView addSubview:nameLablel];
        [contentBgView addSubview:qrBgView];
        [qrBgView addSubview:self.qrImageView];
        [contentBgView addSubview:titleLab];
        
        
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).inset(WidthRatio(49)+HomeIndicatorHeight);
        }];
        [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(closeButton.mas_top).inset(WidthRatio(32));
            make.left.right.equalTo(self).inset(WidthRatio(20));
            make.height.mas_equalTo(WidthRatio(400));
        }];
        
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(contentBgView).inset(WidthRatio(20));
            make.size.mas_equalTo(CGSizeMake(WidthRatio(40), WidthRatio(40)));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar.mas_right).offset(WidthRatio(10));
            make.centerY.equalTo(avatar);
            make.size.mas_equalTo(CGSizeMake(1.f, WidthRatio(30)));
        }];
        
        [nameLablel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(avatar);
            make.left.equalTo(line.mas_right).offset(WidthRatio(20));
            make.right.equalTo(saveButton.mas_left).inset(WidthRatio(10));
        }];
        
        [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentBgView).inset(WidthRatio(20));
            make.centerY.equalTo(avatar);
            make.size.mas_equalTo(CGSizeMake(WidthRatio(84), WidthRatio(32)));
        }];
        
        [qrBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(contentBgView).inset(WidthRatio(60));
            make.bottom.equalTo(avatar.mas_top).inset(WidthRatio(24));
            make.height.equalTo(qrBgView.mas_width);
        }];
        [self.qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(WidthRatio(24), WidthRatio(24), WidthRatio(24), WidthRatio(24)));
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentBgView).inset(WidthRatio(34));
            make.left.right.equalTo(contentBgView).inset(WidthRatio(30));
        }];
        
    }
    return self;
}

- (void)closeButtonAction:(UIButton *)button {
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}


- (void)saveButtonAction:(UIButton *)button {
    if (self.qrImageView.image) {
        [self writeImageToPhotoLibrary:self.qrImageView.image];
    }
}

- (void)writeImageToPhotoLibrary:(UIImage *)image {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status !=PHAuthorizationStatusAuthorized) return; //
        
        // 保存相片到相机胶卷
        __block PHObjectPlaceholder *createdAsset = nil;
        //异步执行
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WXZTipView showBottomWithText:@"保存成功"];
                });
            }else {
                NSLog(@"Error: %@", [error localizedDescription]);
            }
            
        }];
    }];
    
}

@end
