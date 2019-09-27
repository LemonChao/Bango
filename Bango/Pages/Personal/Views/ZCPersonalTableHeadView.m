//
//  ZCPersonalTableHeadView.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalTableHeadView.h"
#import "UIButton+HXExtension.h"

@interface ZCPersonalTableHeadView ()

@property(nonatomic, strong) UIImageView *backgroundImgView;
@property(nonatomic, strong) UIButton *avatarButton;
@property(nonatomic, strong) UILabel *userNameLab;
@property(nonatomic, strong) UILabel *bangoLab;
@property(nonatomic, strong) UIButton *setButton;

@end

@implementation ZCPersonalTableHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImgView];
        [self addSubview:self.avatarButton];
        [self addSubview:self.userNameLab];
        [self addSubview:self.bangoLab];
        
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    
    [self.backgroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.bangoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(58), WidthRatio(18)));
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bangoLab.mas_top);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(WidthRatio(32));
    }];
    
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.userNameLab.mas_top);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(64), WidthRatio(64)));
    }];

    [super updateConstraints];
}

- (void)setModel:(ZCPersonalCenterModel *)model {
    _model = model;
    
    [self.avatarButton sd_setImageWithURL:[NSURL URLWithString:model.avatarhead] forState:UIControlStateNormal placeholderImage:ImageNamed(@"portrait_placeholder_normal") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            UIImage *img = [image imageByResizeToSize:CGSizeMake(WidthRatio(200), WidthRatio(200)) contentMode:UIViewContentModeScaleAspectFill];
            UIImage *roundImg = [img imageByRoundCornerRadius:WidthRatio(100) borderWidth:4.f borderColor:[UIColor whiteColor]];
            [self->_avatarButton setImage:roundImg forState:UIControlStateNormal];
            [self->_avatarButton setImage:roundImg forState:UIControlStateHighlighted];
        }
    }];
    self.userNameLab.text = model.nick_name;
    self.bangoLab.text = model.jibie;
}

- (void)avatarButtonAction:(UIButton *)button {
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    if (info.asstoken) {
        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"personal-data" parameters:nil];
        [[self viewController].navigationController pushViewController:webVC animated:YES];
    }else {
        ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
        loginVC.completeBackToHome = NO;
        [[self viewController] presentViewController:loginVC animated:YES completion:nil];
    }
    
}

#pragma mark - setter && getter

- (UIImageView *)backgroundImgView {
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:GeneralRedColor]];
    }
    return _backgroundImgView;
}

- (UIButton *)avatarButton {
    if (!_avatarButton) {
        _avatarButton = [UITool imageButton:ImageNamed(@"portrait_placeholder_normal")];
        [_avatarButton setEnlargeEdgeWithTop:0 right:0 bottom:30 left:0];
        [_avatarButton addTarget:self action:@selector(avatarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarButton;
}

- (UILabel *)userNameLab {
    if (!_userNameLab) {
        _userNameLab = [UITool labelWithTextColor:HEX_COLOR(0xf5f5f5) font:[UIFont systemFontOfSize:WidthRatio(14) weight:UIFontWeightRegular]];
    }
    return _userNameLab;
}

- (UILabel *)bangoLab {
    if (!_bangoLab) {
        _bangoLab = [UITool labelWithText:@"普通会员" textColor:GeneralRedColor font:[UIFont systemFontOfSize:WidthRatio(11) weight:UIFontWeightRegular] alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor whiteColor]];
        MMViewBorderRadius(_bangoLab, WidthRatio(9), 0, [UIColor clearColor]);
    }
    return _bangoLab;
}

@end
