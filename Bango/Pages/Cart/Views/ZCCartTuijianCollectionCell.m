//
//  ZCCartTuijianCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartTuijianCollectionCell.h"
#import "ZCCartButton.h"

@interface ZCCartTuijianCollectionCell ()

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

@property(nonatomic, strong) UILabel *descriptLab;

/** 市场价，原价 */
@property(nonatomic, strong) UILabel *marketPriceLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *promotionPriceLab;

/** 购物车 */
@property(nonatomic, strong) ZCCartButton *cartButton;
@end


@implementation ZCCartTuijianCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = WidthRatio(4);
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.descriptLab];
        [self.contentView addSubview:self.promotionPriceLab];
        [self.contentView addSubview:self.marketPriceLab];
        [self.contentView addSubview:self.cartButton];
        [self initConstraints];
    }
    return self;
}

- (void)initConstraints {
    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(WidthRatio(173));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(WidthRatio(8));
        make.top.equalTo(self.godsImgView.mas_bottom).offset(WidthRatio(10));
    }];
    
    [self.descriptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(WidthRatio(10));
        make.left.right.equalTo(self.nameLab);
    }];
    
    
    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(WidthRatio(8));
        make.top.equalTo(self.descriptLab.mas_bottom).offset(WidthRatio(15));
    }];
    
    [self.promotionPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cartButton);
        make.left.equalTo(self.nameLab);
    }];
    
    [self.marketPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.promotionPriceLab.mas_bottom).offset(WidthRatio(10));
    }];
    
}
// 只适应高度
//- (void)initConstraints {
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.width.mas_equalTo(WidthRatio(((SCREEN_WIDTH-WidthRatio(29))/2)));
//        make.bottom.equalTo(self.marketPriceLab).offset(WidthRatio(10));
//    }];
//
//
//    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.left.equalTo(self.contentView);
//        make.height.mas_equalTo(WidthRatio(173));
//        make.width.mas_equalTo(WidthRatio(((SCREEN_WIDTH-WidthRatio(29))/2)));
////        make.size.mas_equalTo(CGSizeMake(((SCREEN_WIDTH-WidthRatio(29))/2), WidthRatio(173)));
//    }];
//
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.contentView).inset(WidthRatio(8));
//        make.top.equalTo(self.godsImgView.mas_bottom).offset(WidthRatio(10));
//    }];
//
//    [self.descriptLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nameLab.mas_bottom).offset(WidthRatio(10));
//        make.left.right.equalTo(self.nameLab);
//    }];
//
//
//    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).inset(WidthRatio(8));
//        make.top.equalTo(self.descriptLab.mas_bottom).offset(WidthRatio(15));
//    }];
//
//    [self.promotionPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.cartButton);
//        make.left.equalTo(self.nameLab);
//    }];
//
//    [self.marketPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLab);
//        make.top.equalTo(self.promotionPriceLab.mas_bottom).offset(WidthRatio(10));
////        make.bottom.equalTo(self.contentView);
//    }];
//
//}
//
//- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
//    CGRect newFrame = layoutAttributes.frame;
//    newFrame.size.height = size.height;
//    layoutAttributes.frame = newFrame;
//    return layoutAttributes;
//}


- (void)setModel:(ZCPublicGoodsModel *)model {
    _model = model;
    
    [self.godsImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_cover_mid]];
    self.nameLab.text = model.goods_name;
    self.descriptLab.text = model.introduction;
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
        _godsImgView = [UITool imageViewImage:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleAspectFill];
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

- (ZCCartButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [[ZCCartButton alloc] init];
    }
    return _cartButton;
}

@end
