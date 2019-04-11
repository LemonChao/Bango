//
//  ZCCartValueGodsCell.m
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartValueGodsCell.h"
#import "ZCCartButton.h"

@interface ZCCartValueGodsCell ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *promotionPriceLab;

/** 购物车 */
@property(nonatomic, strong) ZCCartButton *cartButton;

@end

@implementation ZCCartValueGodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.promotionPriceLab];
        [self.contentView addSubview:self.cartButton];
        
        [self initConstraints];
    }
    return self;
}

- (void)initConstraints {
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).inset(WidthRatio(12));
    }];
    
    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.selectButton.mas_right).offset(WidthRatio(10));
        make.size.mas_equalTo(CGSizeMake(WidthRatio(74), WidthRatio(74)));
        make.top.bottom.equalTo(self.contentView).inset(WidthRatio(24));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.godsImgView.mas_right).offset(WidthRatio(10));
        make.top.equalTo(self.godsImgView).offset(WidthRatio(2));
        make.right.equalTo(self.contentView).inset(WidthRatio(12));
    }];
    
    [self.promotionPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.godsImgView.mas_bottom).inset(WidthRatio(10));
    }];
    
    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(WidthRatio(12));
        make.bottom.equalTo(self.godsImgView.mas_bottom).inset(WidthRatio(2));
    }];
}

- (void)setModel:(ZCCartGodsModel *)model {
    _model = model;
    
    [self.godsImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_cover_mid]];
    self.nameLab.text = model.goods_name;
    self.promotionPriceLab.text = model.promotion_price;
    self.cartButton.baseModel = model;
}


#pragma mark - setter && getter

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UITool imageButton:ImageNamed(@"cart_gods_normal")];
        [_selectButton setImage:ImageNamed(@"cart_gods_select") forState:UIControlStateSelected];
    }
    return _selectButton;
}

- (UIImageView *)godsImgView {
    if (!_godsImgView) {
        _godsImgView = [UITool imageViewImage:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleAspectFill];
    }
    return _godsImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14))];
        [_nameLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _nameLab;
}

- (UILabel *)promotionPriceLab {
    if (!_promotionPriceLab) {
        _promotionPriceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(WidthRatio(17))];
    }
    return _promotionPriceLab;
}

- (ZCCartButton *)cartButton {
    if (!_cartButton) {
        _cartButton = [[ZCCartButton alloc] init];
    }
    return _cartButton;
}


@end
