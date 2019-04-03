//
//  ZCHomeBangoCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeBangoCell.h"
#import "UIImageView+WebCache.h"

@interface ZCHomeBangoCell ()

@property(nonatomic, strong) UIImageView *contentImgView;

@end

@implementation ZCHomeBangoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentImgView];
        [self.contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), WidthRatio(5), WidthRatio(12)));
        }];

    }
    return self;
    
}

- (void)setModel:(ZCHomeGodsModel *)model {
    _model = model;
    
    [self.contentImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_cover_small]];
}

- (UIImageView *)contentImgView {
    if (!_contentImgView) {
        _contentImgView = [UITool imageViewPlaceHolder:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(4) borderWidth:0.f borderColor:[UIColor clearColor]];
    }
    return _contentImgView;
}

@end
