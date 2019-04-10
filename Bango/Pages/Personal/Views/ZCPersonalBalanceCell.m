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
        self.stack.backgroundColor = [UIColor redColor];
        self.stack.axis = UILayoutConstraintAxisHorizontal;
        self.stack.distribution = UIStackViewDistributionEqualSpacing;
        self.stack.alignment = UIStackViewAlignmentFill;
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


- (NSArray<__kindof ZCWordsButton *> *)subButtons {
    NSArray *titls = @[@"余额",@"粉丝",@"签到"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < titls.count; i++) {
        ZCWordsButton *button = [[ZCWordsButton alloc] init];
        button.bottomString = titls[i];
        button.topString = @"0";
        [array addObject:button];
    }
    return array.copy;
}


- (void)setModel:(ZCPersonalCenterModel *)model {
    if (!model) return;
    _model = model;
    
    for (ZCWordsButton *button in self.stack.subviews) {
        if ([button.bottomString isEqualToString:@"余额"]) {
            button.topString = model.tot_money;
        }else if ([button.bottomString isEqualToString:@"粉丝"]) {
            button.topString = model.tui_count;
        }else {
            button.topString = StringFormat(@"%@天",model.continuous_signs);
//            button.topString = model.continuous_signs;
        }
    }
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

