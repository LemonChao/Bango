//
//  ZCPersonalTableHeadView.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalTableHeadView.h"
#import "UIButton+WebCache.h"

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
        [self reloadData];
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

- (void)reloadData {
    UserInfoModel *infoModel = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    
    [self.avatarButton sd_setImageWithURL:[NSURL URLWithString:infoModel.avatarhead] forState:UIControlStateNormal placeholderImage:ImageNamed(@"portrait_placeholder_normal") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIImage *img = [image imageByResizeToSize:CGSizeMake(WidthRatio(64), WidthRatio(64)) contentMode:UIViewContentModeScaleAspectFill];
        [self->_avatarButton setImage:[img imageByRoundCornerRadius:WidthRatio(32) borderWidth:WidthRatio(2) borderColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }];
    [self.avatarButton sd_setImageWithURL:[NSURL URLWithString:infoModel.avatarhead] forState:UIControlStateHighlighted placeholderImage:ImageNamed(@"portrait_placeholder_normal") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        UIImage *img = [image imageByResizeToSize:CGSizeMake(WidthRatio(64), WidthRatio(64)) contentMode:UIViewContentModeScaleAspectFill];
        [self->_avatarButton setImage:[img imageByRoundCornerRadius:WidthRatio(32) borderWidth:WidthRatio(2) borderColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }];
    self.userNameLab.text = infoModel.nickName;
}

#pragma mark - setter && getter

- (UIImageView *)backgroundImgView {
    if (!_backgroundImgView) {
        _backgroundImgView = [[UIImageView alloc] initWithImage:ImageNamed(@"personal_headerBG")];
    }
    return _backgroundImgView;
}

- (UIButton *)avatarButton {
    if (!_avatarButton) {
        _avatarButton = [UITool imageButton:ImageNamed(@"portrait_placeholder_normal")];
//        _avatarButton = [UITool imageButton:ImageNamed(@"portrait_placeholder_normal") cornerRadius:WidthRatio(32) borderWidth:0 borderColor:[UIColor clearColor]];
//        _avatarButton.backgroundColor = [UIColor whiteColor];
//        _avatarButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
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
        _bangoLab = [UITool labelWithText:@"搬果小将" textColor:GeneralRedColor font:[UIFont systemFontOfSize:WidthRatio(11) weight:UIFontWeightRegular] alignment:NSTextAlignmentCenter numberofLines:1 backgroundColor:[UIColor whiteColor]];
        MMViewBorderRadius(_bangoLab, WidthRatio(9), 0, [UIColor clearColor]);
    }
    return _bangoLab;
}

@end
