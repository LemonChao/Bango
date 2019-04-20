//
//  ZCPersonalBalanceCell.m
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalBalanceCell.h"

@interface ZCWordsButton : UIControl

@property(nonatomic, copy) NSString *topString;

@property(nonatomic, copy) NSString *bottomString;

@end

@interface ZCPersonalBalanceCell ()

@property(nonatomic, strong) UIStackView *stack;

@end


@implementation ZCPersonalBalanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UIView *bgView = [UITool viewWithColor:[UIColor whiteColor]];
        [self.contentView addSubview:bgView];
        
        self.stack = [[UIStackView alloc] initWithArrangedSubviews:[self subButtons]];
        self.stack.axis = UILayoutConstraintAxisHorizontal;
        self.stack.distribution = UIStackViewDistributionFillEqually;
        self.stack.alignment = UIStackViewAlignmentFill;
        self.stack.spacing = WidthRatio(40);

        [bgView addSubview:self.stack];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(WidthRatio(16), WidthRatio(12), 0, WidthRatio(12)));
        }];
        [self.stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(WidthRatio(14), WidthRatio(25), WidthRatio(14), WidthRatio(25)));
        }];
    }
    return self;
}

- (void)setupStackSubViewsWith:(ZCPersonalCenterModel *)model {
    
    
    if (model.level.integerValue <= 47 && self.stack.arrangedSubviews.count == 3) {//需要减一个
        ZCWordsButton *jiangli = self.stack.arrangedSubviews[0];
        [self.stack removeArrangedSubview:jiangli];
        [jiangli removeFromSuperview];
    }else if (model.level.integerValue > 47 && self.stack.arrangedSubviews.count == 2) {//需要加一个
        ZCWordsButton *button = [[ZCWordsButton alloc] init];
        button.bottomString = @"奖励";
        button.topString = @"0";
        [button addTarget:self action:@selector(balanceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.stack insertArrangedSubview:button atIndex:0];
    }
}



- (NSArray<__kindof ZCWordsButton *> *)subButtons {
    NSArray *titls = @[@"余额",@"能量值"];

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < titls.count; i++) {
        ZCWordsButton *button = [[ZCWordsButton alloc] init];
        button.bottomString = titls[i];
        button.topString = @"0";
        [button addTarget:self action:@selector(balanceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:button];
    }
    return array.copy;
}

- (void)setModel:(ZCPersonalCenterModel *)model {
    if (!model) return;
    
    _model = model;
    [self setupStackSubViewsWith:model];

    for (ZCWordsButton *button in self.stack.arrangedSubviews) {
        if ([button.bottomString isEqualToString:@"奖励"]) {
            button.topString = model.award;
        }else if ([button.bottomString isEqualToString:@"余额"]) {
            button.topString = model.tot_money;
        }else if ([button.bottomString isEqualToString:@"能量值"]) {
            button.topString = model.energy;
        }
    }
}

- (void)balanceButtonAction:(ZCWordsButton *)button {
    if ([button.bottomString isEqualToString:@"余额"]) {
        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"my-balance" parameters:nil];
        [[self viewController].navigationController pushViewController:webVC animated:YES];
    }
//    else if ([button.bottomString isEqualToString:@"奖励"]) {
//        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"direct-recommend" parameters:nil];
//        [[self viewController].navigationController pushViewController:webVC animated:YES];
//    }else {
//        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"personal-data" parameters:nil];
//        [[self viewController].navigationController pushViewController:webVC animated:YES];
//    }

}

@end



@interface ZCWordsButton ()

@property(nonatomic, strong) UILabel *topLable;

@property(nonatomic, strong) UILabel *bottomLable;

@property(nonatomic, assign) CGFloat spacing;

@end


@implementation ZCWordsButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commomInit];
    }
    return self;
}

- (void)commomInit {
    self.topLable = [UITool labelWithTextColor:ImportantColor font:BoldFont(WidthRatio(17)) alignment:NSTextAlignmentCenter];
    self.bottomLable = [UITool labelWithTextColor:ImportantColor font:[UIFont systemFontOfSize:WidthRatio(14) weight:UIFontWeightRegular] alignment:NSTextAlignmentCenter];
    [self addSubview:self.topLable];
    [self addSubview:self.bottomLable];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize {
    
    CGSize topSize = [self.topLable sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize bottomSize = [self.bottomLable sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    CGFloat width = topSize.width > bottomSize.width ? topSize.width : bottomSize.width;
    CGFloat height = topSize.height > bottomSize.height ? topSize.height : bottomSize.height;
    
    if (topSize.height == 0 || bottomSize.height == 0) {
        return CGSizeMake(width, height);
    }else {
        return CGSizeMake(width, topSize.height+bottomSize.height+self.spacing);
    }
    
}




#pragma mark - setter && getter

- (void)setTopString:(NSString *)topString {
    if (_topString == topString || [_topString isEqual:topString]) return;
    
    _topString = topString;
    self.topLable.text = topString;
    [self setNeedsUpdateConstraints];
}

- (void)setBottomString:(NSString *)bottomString {
    if (_bottomString == bottomString || [_bottomString isEqual:bottomString]) return;
    
    _bottomString = bottomString;
    self.bottomLable.text = _bottomString;
    [self setNeedsUpdateConstraints];
}


@end

