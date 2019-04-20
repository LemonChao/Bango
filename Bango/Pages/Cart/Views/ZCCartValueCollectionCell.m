//
//  ZCCartValueCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartValueCollectionCell.h"
#import "ZCCartButton.h"
#import "UIButton+HXExtension.h"


@interface ZCCartValueCollectionCell ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *promotionPriceLab;

/** 购物车 */
@property(nonatomic, strong) ZCCartButton *cartButton;

/** 爆款直降 */
@property(nonatomic, strong) UIImageView *tagImgView1;

/** 运费 */
@property(nonatomic, strong) UIImageView *tagImgView2;
@end


@implementation ZCCartValueCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.tagImgView1 = [[UIImageView alloc] init];
        self.tagImgView2 = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.promotionPriceLab];
        [self.contentView addSubview:self.cartButton];
        [self.contentView addSubview:self.tagImgView1];
        [self.contentView addSubview:self.tagImgView2];
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
    }];

    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.godsImgView.mas_right).offset(WidthRatio(10));
        make.top.equalTo(self.godsImgView).offset(WidthRatio(2));
        make.right.equalTo(self.contentView).inset(WidthRatio(12));
    }];
    
    [self.tagImgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.top.equalTo(self.nameLab.mas_bottom).offset(WidthRatio(5));
    }];
    
    [self.tagImgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagImgView1.mas_right).offset(WidthRatio(10));
        make.top.equalTo(self.tagImgView1);
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


- (void)setModel:(ZCPublicGoodsModel *)model {
    model.deleteEnsure = YES;
    _model = model;
    [self.godsImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_cover_mid]];
    self.nameLab.text = model.goods_name;
    self.promotionPriceLab.text = model.show_promotion_price;
    self.selectButton.selected = model.isSelected;

    self.tagImgView1.image = self.tagImgView2.image = nil;
    for (int i = 0; i < model.tagArray.count; i++) {
        if (i == 0) {
            self.tagImgView1.image = ImageNamed(model.tagArray[i]);
        }else if (i == 1) {
            self.tagImgView2.image = ImageNamed(model.tagArray[i]);
        }
    }
    self.cartButton.baseModel = model;
 }

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
}


- (void)selectButtonAction:(UIButton *)button {
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    
    self.model.selected = !self.model.isSelected;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
    
    NSLog(@"select:%@", collectionView.indexPathsForSelectedItems);
}

#pragma mark - setter && getter

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UITool imageButton:ImageNamed(@"cart_gods_normal")];
        [_selectButton setImage:ImageNamed(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setEnlargeEdgeWithTop:15 right:10 bottom:15 left:10];
    }
    return _selectButton;
}

- (UIImageView *)godsImgView {
    if (!_godsImgView) {
        _godsImgView = [UITool imageViewPlaceHolder:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleToFill cornerRadius:WidthRatio(4) borderWidth:0 borderColor:[UIColor clearColor]];
    }
    return _godsImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UITool labelWithTextColor:ImportantColor font:SystemFont(WidthRatio(14))];
        [_nameLab setContentHuggingPriority:UILayoutPriorityDefaultLow-1 forAxis:UILayoutConstraintAxisHorizontal];
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
