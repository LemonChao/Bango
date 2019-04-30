//
//  ZCSystemNoticeListCell.m
//  Bango
//
//  Created by zchao on 2019/4/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeListCell.h"
#import "ZCSystemNoticeModel.h"
#import "UIView+BadgeValue.h"

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
            make.top.bottom.equalTo(self.contentView).inset(4);
        }];
    }
    
    return self;
}



#pragma mark - setter && getter

- (void)setModel:(ZCSystemNoticeModel *)model {
    _model = model;
    self.titleLab.text = model.notice_title;
    self.timeLab.text = model.showTime;
    self.timeLab.badgeValue = model.is_read.integerValue ? @"-1":@"0";
}



- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(14)];
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UITool labelWithTextColor:AssistColor font:SystemFont(11)];
    }
    return _timeLab;
}


@end
