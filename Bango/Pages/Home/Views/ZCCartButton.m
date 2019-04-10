//
//  ZCCartButton.m
//  Bango
//
//  Created by zchao on 2019/4/3.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartButton.h"
#import "ZCBaseModel.h"

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


- (void)setBaseModel:(ZCBaseModel *)baseModel {
    _baseModel = baseModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        @weakify(self);
        RAC(self.countLab, text) = RACObserve(self, baseModel.count);
        [RACObserve(self, baseModel.hide) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.divisionButton.hidden = self.countLab.hidden = [x boolValue];
        }];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        @weakify(self);
        RAC(self.countLab, text) = RACObserve(self, baseModel.count);
        [RACObserve(self, baseModel.hide) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.divisionButton.hidden = self.countLab.hidden = [x boolValue];
            [self.addButton setImage:[x boolValue] ? ImageNamed(@"tabBar3_select"): ImageNamed(@"home_add") forState:UIControlStateNormal];
        }];
    }
    return self;
}


- (void)commonInit {
    self.addButton = [UITool imageButton:ImageNamed(@"tabBar3_select")];
    self.divisionButton = [UITool imageButton:ImageNamed(@"home_division")];
    self.countLab = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14)) alignment:NSTextAlignmentCenter];
    self.divisionButton.hidden = self.countLab.hidden = YES;
    [self.countLab setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.addButton];
    [self addSubview:self.divisionButton];
    [self addSubview:self.countLab];
    
    
    @weakify(self);
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.baseModel.count = [NSString stringWithFormat:@"%ld", self.baseModel.count.integerValue+1];
        self.baseModel.hide = ![self.baseModel.count boolValue];
    }];
    
    [[self.divisionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        self.baseModel.count = [NSString stringWithFormat:@"%ld", self.baseModel.count.integerValue-1];
        
        self.baseModel.hide = ![self.baseModel.count boolValue];
    }];
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


//- (void)addButtonAction:(UIButton *)button {
//
//    NSInteger count = self.count.integerValue+1;
//    self.count = [NSString stringWithFormat:@"%ld", count];
//
//    if (count == 1) {
//        self.divisionButton.hidden = self.countLab.hidden = NO;
//        [self.addButton setImage:ImageNamed(@"home_add") forState:UIControlStateNormal];
//    }
//
//}
//
//- (void)divisionButtonAction:(UIButton *)button {
//    NSInteger count = self.count.integerValue-1;
//    self.count = [NSString stringWithFormat:@"%ld", count];
//    if (count <= 0) {
//        [self.addButton setImage:ImageNamed(@"tabBar3_select") forState:UIControlStateNormal];
//        self.divisionButton.hidden = self.countLab.hidden = YES;
//    }
//
//}


@end
