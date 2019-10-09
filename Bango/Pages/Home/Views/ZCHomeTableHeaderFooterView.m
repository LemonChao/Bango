//
//  ZCHomeTableHeaderFooterView.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeTableHeaderFooterView.h"
#import "UIButton+EdgeInsets.h"

@interface ZCHomeTableHeaderView ()

@property(nonatomic, strong) UILabel *titleLab;

@property(nonatomic, strong) UIButton *moreButton;

@end

@implementation ZCHomeTableHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLab = [UITool labelWithTextColor:ImportantColor font:BoldFont(WidthRatio(20))];
        self.moreButton = [UITool richButton:UIButtonTypeCustom title:@"查看更多" titleColor:GeneralRedColor font:MediumFont(WidthRatio(14)) bgColor:[UIColor whiteColor] image:[ImageNamed(@"home_arrow_right") imageByTintColor:GeneralRedColor]];
        [self.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.moreButton];
        
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).inset(WidthRatio(12));
        }];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).inset(WidthRatio(12));
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(WidthRatio(71));
        }];
        
        [self setNeedsLayout];
        [self.moreButton setImagePosition:ZCImagePositionRight spacing:WidthRatio(5)];
    }
    return self;
}

- (void)setModel:(ZCHomeEverygodsModel *)model {
    _model = model;
    self.titleLab.text = model.category_alias;
    self.moreButton.hidden = [model.category_alias isEqualToString:@"成为搬果小将"];
}

- (void)moreButtonAction:(UIButton *)button {
    UIViewController *baseVC = [self viewController];
    
    NSDictionary *dic;
    if ([self.model.category_alias isEqualToString:@"爆款推荐"] || [self.model.category_alias isEqualToString:@"大家一起拼"]) {
        dic = @{@"type":self.model.category_id};
    }else {
        dic = @{@"category_id":self.model.category_id};
    }
    
    ZCWebViewController *webView = [[ZCWebViewController alloc] initWithPath:@"search-result" parameters:dic];
    [baseVC.navigationController pushViewController:webView animated:YES];
}

//- (ZCBaseViewController *)viewController {
//    UIView *next = self;
//    while ((next = [next superview])) {
//        UIResponder *nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[ZCBaseViewController class]]) {
//            return (ZCBaseViewController *)nextResponder;
//        }
//    }
//    return nil;
//}



@end

@interface ZCHomeTableFooterView ()

@end

@implementation ZCHomeTableFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];

        UIView *lineView = [UITool viewWithColor:LineColor];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(WidthRatio(5), WidthRatio(12), WidthRatio(12), WidthRatio(12)));
        }];
    }
    return self;
}

@end


@interface ZCHomeBlankTableHeaderFooterView ()

@end

@implementation ZCHomeBlankTableHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
