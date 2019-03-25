//
//  FaceShareView.m
//  Bango
//
//  Created by zchao on 2019/3/19.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "FaceShareView.h"
#import "UserInfoModel.h"
#import "JQScanWrapper.h"
#import "UIImage+Developer.h"

@interface FaceShareView()

@property(nonatomic, strong) UIImage *qrImage;
@property(nonatomic, strong) UIImage *shareImage;
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
        self.qrImage = [JQScanWrapper createQRWithString:urlString size:CGSizeMake(SCREEN_WIDTH-WidthRatio(104), SCREEN_WIDTH-WidthRatio(104))];
        UIImageView *qrImageView = [UITool imageViewImage:self.qrImage contentMode:UIViewContentModeScaleToFill];
        self.shareImage = [UIImage imageWithView:[self savedView] size:CGSizeZero];


        [self addSubview:closeButton];
        [self addSubview:contentBgView];
        [contentBgView addSubview:avatar];
        [contentBgView addSubview:saveButton];
        [contentBgView addSubview:line];
        [contentBgView addSubview:nameLablel];
        [contentBgView addSubview:qrBgView];
        [qrBgView addSubview:qrImageView];
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
        [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    if (self.shareImage) {
        [BaseMethod writeImageToPhotoLibrary:self.shareImage];
    }
}

/** 生成保存视图view */
- (UIView *)savedView {
    
    UIView *backgroundView = [UITool viewWithColor:[UIColor blackColor]];
    backgroundView.frame = CGRectMake(0, 0, WidthRatio(278), WidthRatio(314));
    UIView *cornerView = [UITool viewCornerRadius:WidthRatio(17)];
    cornerView.backgroundColor = RGBA(252, 83, 87, 1);
    UIView *topCornerView = [UITool viewCornerRadius:WidthRatio(17)];
    topCornerView.backgroundColor = [UIColor blackColor];
    UIImageView *shareBg = [[UIImageView alloc] initWithImage:ImageNamed(@"face_invite_box")];
    UIImageView *logoView = [[UIImageView alloc] initWithImage:ImageNamed(@"face_invite_title")];
    UILabel *titleLab = [UITool labelWithText:@"新鲜  品质  超值" textColor:[UIColor whiteColor] font:MediumFont(15)];
    UILabel *noteLab = [UITool labelWithText:@"长按识别二维码" textColor:[UIColor whiteColor] font:MediumFont(WidthRatio(11))];
    UIButton *qrButton = [UITool imageButton:self.qrImage cornerRadius:WidthRatio(15) borderWidth:0 borderColor:[UIColor clearColor]];
    qrButton.userInteractionEnabled = NO;
    qrButton.backgroundColor = [UIColor whiteColor];
    [qrButton setContentEdgeInsets:UIEdgeInsetsMake(WidthRatio(18), WidthRatio(18), WidthRatio(18), WidthRatio(18))];
    
    [backgroundView addSubview:topCornerView];
    [backgroundView addSubview:cornerView];
    [backgroundView addSubview:logoView];
    [cornerView addSubview:titleLab];
    [cornerView addSubview:noteLab];
    [cornerView addSubview:qrButton];
    [backgroundView addSubview:shareBg];
    
    [topCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, WidthRatio(244), 0));
    }];
    [cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(WidthRatio(68), 0, 0, 0));
    }];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView).inset(WidthRatio(12));
        make.centerX.equalTo(backgroundView);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(228), WidthRatio(45)));
    }];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cornerView).inset(WidthRatio(16));
        make.centerX.equalTo(cornerView);
    }];
    [noteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cornerView);
        make.bottom.equalTo(cornerView).inset(WidthRatio(15));
    }];
    [qrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cornerView);
        make.bottom.equalTo(noteLab.mas_top).inset(WidthRatio(10));
        make.size.mas_equalTo(CGSizeMake(WidthRatio(165), WidthRatio(165)));
    }];

    [shareBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backgroundView);
    }];
    
    [backgroundView layoutIfNeeded];
    
    return backgroundView;
}



@end
