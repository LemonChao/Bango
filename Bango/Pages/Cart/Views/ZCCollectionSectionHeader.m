//
//  ZCCollectionSectionHeader.m
//  Bango
//
//  Created by zchao on 2019/4/10.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCollectionSectionHeader.h"

@interface ZCCollectionSectionHeader ()

//@property(nonatomic, strong) <#Class#> *<#object#>;


@end

@implementation ZCCollectionSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topBG = [UITool viewWithColor:[UIColor whiteColor]];
        
        UIButton *likeButton = [UITool wordButton:UIButtonTypeCustom title:@"猜你喜欢" titleColor:ImportantColor font:MediumFont(WidthRatio(14)) bgColor:[UIColor clearColor]];
        [likeButton setBackgroundImage:ImageNamed(@"cart_gussLike") forState:UIControlStateNormal];
        UIButton *emptyButton = [UITool richButton:UIButtonTypeCustom title:@"去逛逛" titleColor:GeneralRedColor font:SystemFont(17) bgColor:[UIColor clearColor] image:ImageNamed(@"public_emptyContent")];
        emptyButton.frame = CGRectMake((SCREEN_WIDTH-WidthRatio(123))/2, WidthRatio(44), WidthRatio(123), WidthRatio(136));
        [emptyButton setImagePosition:ZCImagePositionTop spacing:WidthRatio(20)];
        UILabel *emptyLabel = [UITool labelWithText:@"购物车空空如也~" textColor:AssistColor font:SystemFont(11)];
        
        [self addSubview:likeButton];
        [self addSubview:topBG];
        [topBG addSubview:emptyButton];
        [topBG addSubview:emptyLabel];
        
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).inset(WidthRatio(14));
        }];

        [topBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(likeButton.mas_top).inset(WidthRatio(28));
        }];
        
        [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(emptyButton.mas_bottom).offset(WidthRatio(10));
        }];
                
    }
    return self;
}


@end
