//
//  ZCCartBottomView.m
//  Bango
//
//  Created by zchao on 2019/4/12.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartBottomView.h"

@interface ZCCartBottomView ()

@property(nonatomic, strong) UIButton *selectAllBtn;

@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) UIButton *jieSuanButton;

@end

@implementation ZCCartBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *hejiLab = [UITool labelWithText:@"合计" textColor:ImportantColor font:SystemFont(14)];
    UILabel *yunfeiLab = [UITool labelWithText:@"不含运费" textColor:AssistColor font:SystemFont(WidthRatio(11))];
    
    [self addSubview:self.selectAllBtn];
    [self addSubview:hejiLab];
    [self addSubview:self.countLabel];
    [self addSubview:yunfeiLab];
    [self addSubview:self.jieSuanButton];
    
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(WidthRatio(12));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(64), WidthRatio(50)));
    }];
    [hejiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(WidthRatio(12));
        make.bottom.equalTo(self.selectAllBtn.mas_centerY);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hejiLab);
        make.left.equalTo(hejiLab.mas_right).offset(WidthRatio(6));
    }];
    [yunfeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(WidthRatio(12));
        make.top.equalTo(self.selectAllBtn.mas_centerY).offset(WidthRatio(2));
    }];
    [self.jieSuanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(WidthRatio(126));
    }];
    
    [self layoutIfNeeded];
    [_selectAllBtn setImagePosition:ZCImagePositionLeft spacing:WidthRatio(10)];
    [self.jieSuanButton setImagePosition:ZCImagePositionRight spacing:WidthRatio(10)];

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)selectAllButtonAction:(UIButton *)button {
    
}

- (void)jieSuanButtonAction:(UIButton *)button {
    
}



#pragma mark - setter && getter
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
    }
    return _countLabel;
}

- (UIButton *)selectAllBtn {
    if (!_selectAllBtn) {
        _selectAllBtn = [UITool richButton:UIButtonTypeCustom title:@"全选" titleColor:ImportantColor font:SystemFont(WidthRatio(14)) bgColor:[UIColor clearColor] image:ImageNamed(@"cart_gods_normal")];
        [_selectAllBtn setImage:ImageNamed(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectAllBtn addTarget:self action:@selector(selectAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)jieSuanButton {
    if (!_jieSuanButton) {
        _jieSuanButton = [UITool richButton:UIButtonTypeCustom title:@"去结算" titleColor:[UIColor whiteColor] font:MediumFont(WidthRatio(17)) bgColor:GeneralRedColor image:ImageNamed(@"cart_jiesuan_arrow")];
        [_jieSuanButton addTarget:self action:@selector(jieSuanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jieSuanButton;
}


@end
