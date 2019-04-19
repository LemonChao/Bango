//
//  ZCHomeNoticeCell.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeNoticeCell.h"
#import "TXScrollLabelView.h"
#import "UIButton+EdgeInsets.h"

@interface ZCHomeNoticeCell ()<TXScrollLabelViewDelegate>

@property(nonatomic, strong) UIButton *leftButton;

@property(nonatomic, strong) UIButton *rightButton;

@property(nonatomic, strong) TXScrollLabelView *scrollLabelView;

@end

@implementation ZCHomeNoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *cornerBg = [UITool viewCornerRadius:WidthRatio(16) borderWidth:1.f borderColor:HEX_COLOR(0xF5F5F5)];
        
        self.leftButton = [UITool imageButton:ImageNamed(@"home_notice")];
        UIImage *lineImage = [UIImage imageWithColor:HEX_COLOR(0xF5F5F5) size:CGSizeMake(1, WidthRatio(14))];
        self.rightButton = [UITool richButton:UIButtonTypeCustom title:@"查看" titleColor:ImportantColor font:[UIFont systemFontOfSize:WidthRatio(14) weight:UIFontWeightRegular] bgColor:[UIColor whiteColor] image:lineImage];
        [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cornerBg];
        [cornerBg addSubview:self.rightButton];
        [cornerBg addSubview:self.scrollLabelView];
        [cornerBg addSubview:self.leftButton];
        
        [cornerBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView).inset(WidthRatio(12));
        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cornerBg);
            make.left.equalTo(cornerBg).inset(WidthRatio(15));
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cornerBg).inset(WidthRatio(15));
            make.centerY.equalTo(cornerBg);
            make.width.mas_equalTo(WidthRatio(38));
        }];
        
        [self.scrollLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(cornerBg).inset(1);
            make.left.equalTo(self.leftButton.mas_right).offset(WidthRatio(10));
            make.right.equalTo(self.rightButton.mas_left).inset(WidthRatio(10));
        }];
        
        [self layoutIfNeeded];
        
        [self.rightButton setImagePosition:ZCImagePositionLeft spacing:WidthRatio(10)];
    }
    return self;
}

- (void)setNotics:(NSArray<__kindof ZCHomeNoticeModel *> *)notics {
    _notics = notics;
    NSMutableArray *marray = [NSMutableArray array];
    
    for (ZCHomeNoticeModel *item in notics) {
        [marray addObject:item.notice_title];
    }
    [self.scrollLabelView startScrollingWithArray:marray];
}

- (void)rightButtonAction:(UIButton *)button {
    UIViewController *baseVC = [self viewController];
    ZCWebViewController *webView = [[ZCWebViewController alloc] initWithPath:@"notice-list" parameters:nil];
    [baseVC.navigationController pushViewController:webView animated:YES];
}


- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index {
    ZCHomeNoticeModel *model = self.notics[index];
    UIViewController *baseVC = [self viewController];
    NSDictionary *dic = @{@"id":model.notice_id};
    ZCWebViewController *webView = [[ZCWebViewController alloc] initWithPath:@"notice-detail" parameters:dic];
    [baseVC.navigationController pushViewController:webView animated:YES];
}

- (TXScrollLabelView *)scrollLabelView {
    if (!_scrollLabelView) {
        _scrollLabelView = [TXScrollLabelView scrollWithTextArray:nil type:TXScrollLabelViewTypeUpDown velocity:2.5 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        _scrollLabelView.scrollLabelViewDelegate = self;
        _scrollLabelView.textAlignment = NSTextAlignmentLeft;
        _scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        _scrollLabelView.scrollSpace = 10;
        _scrollLabelView.font = [UIFont systemFontOfSize:WidthRatio(14) weight:UIFontWeightRegular];
        _scrollLabelView.scrollTitleColor = ImportantColor;
        _scrollLabelView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollLabelView;
}


@end
