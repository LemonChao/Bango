//
//  ZCHomeRecommendCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/1.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeRecommendCollectionCell.h"

@interface ZCHomeRecommendCollectionCell ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation ZCHomeRecommendCollectionCell

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

- (void)setModel:(ZCHomeTuijianModel *)model {
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
