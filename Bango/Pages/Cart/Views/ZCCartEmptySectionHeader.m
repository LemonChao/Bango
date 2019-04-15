//
//  ZCCartEmptySectionHeader.m
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartEmptySectionHeader.h"

@implementation ZCCartEmptySectionHeader

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

@implementation ZCCartTuijianSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *likebgView = [[UIImageView alloc] initWithImage:ImageNamed(@"cart_gussLike")];
        UILabel *likelabel = [UITool labelWithText:@"猜你喜欢" textColor:ImportantColor font:MediumFont(WidthRatio(14))];
        [self addSubview:likebgView];
        [self addSubview:likelabel];
        
        [likebgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [likelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
    }
    return self;
}

@end

@interface ZCCartShopNameSctionHeader ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIButton *shopNameBtn;

@end

@implementation ZCCartShopNameSctionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectButton = [UITool imageButton:ImageNamed(@"cart_gods_normal")];
        [self.selectButton setImage:ImageNamed(@"cart_gods_select") forState:UIControlStateSelected];
        [self.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shopNameBtn = [UITool wordButton:nil titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor]];
        self.shopNameBtn.userInteractionEnabled = NO;
        
        [self addSubview:self.selectButton];
        [self addSubview:self.shopNameBtn];
        
        [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).inset(WidthRatio(12));
        }];
        
        [self.shopNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.selectButton.mas_right).offset(WidthRatio(10));
        }];
        
    }
    return self;
}


- (void)setModel:(ZCCartModel *)model {
    _model = model;
    
    [self.shopNameBtn setTitle:model.shop_name forState:UIControlStateNormal];
    
    self.selectButton.selected = model.isSelectAll;
}

- (void)selectButtonAction:(UIButton *)button {
    self.model.selectAll = !self.model.isSelectAll;
    for (ZCPublicGoodsModel *item in self.model.shop_goods) {
        item.selected = self.model.selectAll;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
}


@end


@interface ZCCartInvaluedSectionHeader()


@end

@implementation ZCCartInvaluedSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [UITool labelWithText:@"失效商品" textColor:AssistColor font:MediumFont(14)];
        UIButton *deleteButton = [UITool wordButton:@"一键清空失效商品" titleColor:GeneralRedColor font:MediumFont(14) bgColor:[UIColor clearColor]];
        
        [self addSubview:titleLabel];
        [self addSubview:deleteButton];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).inset(WidthRatio(12));
        }];
        
        [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).inset(WidthRatio(12));
        }];
        
    }
    return self;
}

@end


