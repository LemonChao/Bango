//
//  ZCCategoryCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCategoryCollectionCell.h"
#import "UIButton+EdgeInsets.h"

@interface ZCCategoryCollectionCell ()

@property(nonatomic, strong) UIButton *button;

@end

@implementation ZCCategoryCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setModel:(ZCHomeCategoryModel *)model {
    _model = model;
    
    @weakify(self);
    [self.button setImageWithURL:[NSURL URLWithString:model.category_pic] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionShowNetworkActivity  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        [self_weak_.button setImage:[image imageByResizeToSize:CGSizeMake(WidthRatio(58), WidthRatio(58))] forState:UIControlStateNormal];
        [self_weak_.button setTitle:model.category_name forState:UIControlStateNormal];
        [self_weak_.button setImagePosition:ZCImagePositionTop spacing:WidthRatio(6)];
    }];
}


- (UIButton *)button {
    if (!_button) {
        _button = [UITool richButton:UIButtonTypeCustom title:nil titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor] image:ImageNamed(@"list_placeholder_normal")];
        _button.userInteractionEnabled = NO;
    }
    return _button;
}



@end
