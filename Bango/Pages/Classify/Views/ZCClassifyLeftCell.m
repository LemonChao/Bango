//
//  ZCClassifyLeftCell.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCClassifyLeftCell.h"

@interface ZCClassifyLeftCell ()

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UIButton *titleButton;

@end

@implementation ZCClassifyLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleButton];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
    }];
    
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView).inset(WidthRatio(5));
    }];
    
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imgView.hidden = !selected;
    self.titleButton.selected = selected;
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : RGBA(245, 245, 245, 1);
}

- (void)setModel:(ZCClassifyModel *)model {
    [self.titleButton setTitle:model.category_name forState:UIControlStateSelected];
    [self.titleButton setTitle:model.category_name forState:UIControlStateNormal];
}



- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:ImageNamed(@"classify_shu_red")];
    }
    return _imgView;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UITool wordButton:nil titleColor:ImportantColor font:MediumFont(WidthRatio(14)) bgColor:[UIColor clearColor]];
        [_titleButton setTitleColor:GeneralRedColor forState:UIControlStateSelected];
        _titleButton.userInteractionEnabled = NO;
    }
    return _titleButton;
}

@end
