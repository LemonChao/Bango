//
//  ZCNewsCenterCell.m
//  Bango
//
//  Created by zchao on 2019/4/28.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCNewsCenterCell.h"
#import "UIView+BadgeValue.h"
#import "ZCSystemNoticeVM.h"

@interface ZCNewsCenterCell ()


@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UILabel *titleLab;

@property(nonatomic, strong) UILabel *timeLab;

@end

@implementation ZCNewsCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [UITool viewWithColor:[UIColor whiteColor]];
        [self.contentView addSubview:bgView];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.timeLab];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).inset(1);
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).inset(WidthRatio(12));
            make.centerY.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).inset(WidthRatio(14));
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView);
            make.left.equalTo(self.imgView.mas_right).offset(WidthRatio(10));
        }];

        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.imgView);
            make.right.equalTo(self.contentView).inset(WidthRatio(12));
        }];
        
    }
    return self;
}

- (void)setCellViewModel:(ZCSystemNoticeVM *)cellViewModel {
    _cellViewModel = cellViewModel;
    self.timeLab.text = cellViewModel.showTime;
    self.imgView.badgeValue = StringFormat(@"%@", cellViewModel.isReaded ? @"-1":@"0");
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:ImageNamed(@"bg_newsCenter_list2")];
    }
    return _imgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _titleLab.text = @"系统公告";
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
