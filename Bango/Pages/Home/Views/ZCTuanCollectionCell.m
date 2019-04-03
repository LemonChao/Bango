//
//  ZCTuanCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCTuanCollectionCell.h"

@interface ZCTuanCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ZCTuanCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setModel:(ZCHomePintuanModel *)model {
    _model = model;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:model.pic_cover_mid] options:YYWebImageOptionShowNetworkActivity];
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UITool imageViewPlaceHolder:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(4) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _imageView;
}


@end
