//
//  ZCClassifyRightCell.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyRightCell.h"
#import "ZCCartClassifyButton.h"
#import "UIImageView+WebCache.h"


@interface ZCClassifyRightCell ()

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

@property(nonatomic, strong) UILabel *descriptLab;

/** 市场价，原价 */
@property(nonatomic, strong) UILabel *marketPriceLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *promotionPriceLab;

/** 购物车 */
@property(nonatomic, strong) ZCCartClassifyButton *cartButton;

/** 购物车内容view */
@property(nonatomic, strong) UIView *cartContentView;

@end

@implementation ZCClassifyRightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.descriptLab];
        [self.contentView addSubview:self.cartButton];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.promotionPriceLab];
        [self.contentView addSubview:self.marketPriceLab];
        [self.contentView addSubview:self.lineView];
        
        [self setNeedsUpdateConstraints];

    }
    return self;
}


- (void)updateConstraints {
    CGFloat margin = 12;
    
    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(WidthRatio(margin));
        make.top.equalTo(self.contentView).inset(WidthRatio(10));
        make.bottom.equalTo(self.lineView.mas_top).inset(WidthRatio(10));
        make.height.equalTo(self.godsImgView.mas_width);
    }];
    
    [self.descriptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.godsImgView.mas_right).offset(WidthRatio(10));
        make.right.equalTo(self.contentView).inset(WidthRatio(margin));
        make.height.mas_equalTo(WidthRatio(12));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.descriptLab);
        make.bottom.equalTo(self.descriptLab.mas_top).offset(-WidthRatio(10));
    }];
    
    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(WidthRatio(margin));
        make.top.equalTo(self.descriptLab.mas_bottom).offset(WidthRatio(15));
    }];
    
    
    [self.promotionPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cartButton);
        make.left.equalTo(self.descriptLab);
    }];
    
    [self.marketPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.descriptLab);
        make.top.equalTo(self.promotionPriceLab.mas_bottom).offset(WidthRatio(10));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(margin);
        make.bottom.equalTo(self.contentView).inset(1);
        make.height.mas_equalTo(1);
    }];
    
    [super updateConstraints];
}

- (void)setModel:(ZCPublicGoodsModel *)model {
    _model = model;
    
    [self.godsImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_cover_mid]];
    self.nameLab.text = model.goods_name;
    self.descriptLab.text = model.goods_name;
    self.promotionPriceLab.text = model.show_promotion_price;
    self.cartButton.baseModel = model;
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:model.show_market_price];
    attText.strikethroughStyle = NSUnderlineStyleSingle;
    attText.strikethroughColor = AssistColor;
    self.marketPriceLab.attributedText = attText;

}

#pragma mark - setter && getter

- (UIImageView *)godsImgView {
    if (!_godsImgView) {
        _godsImgView = [UITool imageViewPlaceHolder:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(4) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _godsImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14))];
    }
    return _nameLab;
}

- (UILabel *)descriptLab {
    if (!_descriptLab) {
        _descriptLab = [UITool labelWithTextColor:AssistColor font:MediumFont(WidthRatio(11))];
    }
    return _descriptLab;
}

- (UILabel *)promotionPriceLab {
    if (!_promotionPriceLab) {
        _promotionPriceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(WidthRatio(17))];
    }
    return _promotionPriceLab;
}

- (UILabel *)marketPriceLab {
    if (!_marketPriceLab) {
        _marketPriceLab = [UITool labelWithTextColor:AssistColor font:MediumFont(WidthRatio(11))];
    }
    return _marketPriceLab;
}

- (ZCCartClassifyButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [[ZCCartClassifyButton alloc] init];
    }
    return _cartButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UITool viewWithColor:LineColor];
    }
    return _lineView;
}

@end
