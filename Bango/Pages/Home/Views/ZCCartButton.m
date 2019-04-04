//
//  ZCCartButton.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartButton.h"

@interface ZCCartButton ()
/** 购物车 */
@property(nonatomic, strong) UIButton *cartButton;

/** 添加 */
@property(nonatomic, strong) UIButton *addButton;

/** 减法 */
@property(nonatomic, strong) UIButton *divisionButton;

/** 购买数量 */
@property(nonatomic, strong) UILabel *countLab;

@end

@implementation ZCCartButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)addButtonAction:(UIButton *)button {
    
    NSInteger count = self.count.integerValue+1;
    self.count = [NSString stringWithFormat:@"%ld", count];
    
    if (count == 1) {
        self.divisionButton.hidden = self.countLab.hidden = NO;
        [self.addButton setImage:ImageNamed(@"home_add") forState:UIControlStateNormal];
    }

}

- (void)divisionButtonAction:(UIButton *)button {
    NSInteger count = self.count.integerValue-1;
    self.count = [NSString stringWithFormat:@"%ld", count];
    if (count <= 0) {
        [self.addButton setImage:ImageNamed(@"tabBar3_select") forState:UIControlStateNormal];
        self.divisionButton.hidden = self.countLab.hidden = YES;
    }

}


- (void)commonInit {
    self.count = @"0";
    self.addButton = [UITool imageButton:ImageNamed(@"tabBar3_select")];
    self.divisionButton = [UITool imageButton:ImageNamed(@"home_division")];
    self.countLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14)) alignment:NSTextAlignmentCenter];
    self.divisionButton.hidden = self.countLab.hidden = YES;
    [self.countLab setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    self.countLab.text = @"1";
    [self addSubview:self.addButton];
    [self addSubview:self.divisionButton];
    [self addSubview:self.countLab];
    
//    [self.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.divisionButton addTarget:self action:@selector(divisionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSInteger count = self.count.integerValue+1;
        self.count = [NSString stringWithFormat:@"%ld", count];

        if (count == 1) {
            self.divisionButton.hidden = self.countLab.hidden = NO;
            [self.addButton setImage:ImageNamed(@"home_add") forState:UIControlStateNormal];
        }
    }];


    [[self.divisionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSInteger count = self.count.integerValue-1;
        self.count = [NSString stringWithFormat:@"%ld", count];
        if (count <= 0) {
            [self.addButton setImage:ImageNamed(@"tabBar3_select") forState:UIControlStateNormal];
            self.divisionButton.hidden = self.countLab.hidden = YES;
        }
    }];

    RAC(self.countLab, text) = RACObserve(self, count);
    
    
    [self setNeedsUpdateConstraints];
}



- (void)updateConstraints {
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
    }];
    
    [self.divisionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.divisionButton.mas_right);
        make.right.equalTo(self.addButton.mas_left);
    }];
    
    [super updateConstraints];
}


- (CGSize)intrinsicContentSize {
    return CGSizeMake(76.f, 23.f);
}

@end
