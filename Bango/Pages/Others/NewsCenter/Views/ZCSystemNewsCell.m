//
//  ZCSystemNewsCell.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNewsCell.h"

@interface ZCSystemNewsCell ()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UILabel *timeLab;

@property(nonatomic, strong) UIButton *newsTitleBtn;

@property(nonatomic, strong) UIButton *descriptBtn;

@end


@implementation ZCSystemNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bgView = [UITool viewWithColor:[UIColor whiteColor]];
        MMViewBorderRadius(self.bgView, WidthRatio(4), 0, [UIColor clearColor]);
        self.timeLab = [UITool labelWithTextColor:AssistColor font:SystemFont(11)];
        self.newsTitleBtn = [UITool richButton:UIButtonTypeCustom title:@"优惠券到账提醒" titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor] image:nil];
        self.newsTitleBtn.contentEdgeInsets = UIEdgeInsetsZero;
        self.descriptBtn = [UITool richButton:UIButtonTypeCustom title:@"您有一张50元代金券已经到账，快去花掉它吧~" titleColor:AssistColor font:MediumFont(11) bgColor:[UIColor clearColor] image:ImageNamed(@"home_arrow_right")];
        
        self.timeLab.text = @"2019年04月12号";
        
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.timeLab];
        [self.bgView addSubview:self.newsTitleBtn];
        [self.bgView addSubview:self.descriptBtn];
        

        [self initConstraints];
//        [self.descriptBtn setImagePosition:ZCImagePositionRight WithMargin:0];
    }
    
    return self;
}


- (void)initConstraints {
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(WidthRatio(12));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).inset(WidthRatio(12));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView);
        make.top.mas_equalTo(WidthRatio(16));
    }];
    
    [self.newsTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).inset(WidthRatio(10));
        make.top.equalTo(self.bgView).offset(WidthRatio(32));
        make.bottom.equalTo(self.descriptBtn.mas_top).offset(-WidthRatio(8));
    }];
    
    [self.descriptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRatio(10));
        make.width.mas_equalTo(SCREEN_WIDTH - WidthRatio(44));
        make.bottom.equalTo(self.bgView.mas_bottom).inset(WidthRatio(10));
    }];
}



@end
