//
//  ZCSystemNoticeListCell.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeListCell.h"

@interface ZCSystemNoticeListCell ()

@property(nonatomic, strong) UILabel *titleLab;

@property(nonatomic, strong) UILabel *timeLab;

@end


@implementation ZCSystemNoticeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.separatorInset = UIEdgeInsetsMake(0, WidthRatio(12), 0, WidthRatio(12));
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.timeLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).inset(WidthRatio(12));
            make.bottom.equalTo(self.contentView).inset(WidthRatio(15));
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right).offset(WidthRatio(5));
            make.right.equalTo(self.contentView).inset(WidthRatio(12));
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    return self;
}



#pragma mark - setter && getter

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(14)];
        _titleLab.text = @"占位《搬果将用户注册协议》占位《搬果将用户注册协议》占位《搬果将用户注册协议》占位《搬果将用户注册协议》占位《搬果将用户注册协议》";
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UITool labelWithTextColor:AssistColor font:SystemFont(11)];
        _timeLab.text = @"2019/04/04";
    }
    return _timeLab;
}


@end
