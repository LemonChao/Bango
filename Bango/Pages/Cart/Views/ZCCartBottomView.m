//
//  ZCCartBottomView.m
//  Bango
//
//  Created by zchao on 2019/4/12.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartBottomView.h"

@interface ZCCartBottomView ()

@property(nonatomic, strong) UIButton *selectAllBtn;

@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) UIButton *jieSuanButton;

@end

@implementation ZCCartBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        
        @weakify(self);
        [RACObserve(self, viewModel.totalPrice) subscribeNext:^(NSNumber  *_Nullable x) {
            @strongify(self);
            self.countLabel.text = StringFormat(@"￥%@",x);
            self.jieSuanButton.enabled = [x boolValue];
        }];
        
        RAC(self.selectAllBtn,selected) = [RACObserve(self, viewModel.selectAll) skip:1];
    }
    return self;
}


- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *hejiLab = [UITool labelWithText:@"合计" textColor:ImportantColor font:SystemFont(14)];
    UILabel *yunfeiLab = [UITool labelWithText:@"不含运费" textColor:AssistColor font:SystemFont(WidthRatio(11))];
    
    [self addSubview:self.selectAllBtn];
    [self addSubview:hejiLab];
    [self addSubview:self.countLabel];
    [self addSubview:yunfeiLab];
    [self addSubview:self.jieSuanButton];
    
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(WidthRatio(12));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(64), WidthRatio(50)));
    }];
    [hejiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(WidthRatio(12));
        make.bottom.equalTo(self.selectAllBtn.mas_centerY);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hejiLab);
        make.left.equalTo(hejiLab.mas_right).offset(WidthRatio(6));
    }];
    [yunfeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(WidthRatio(12));
        make.top.equalTo(self.selectAllBtn.mas_centerY).offset(WidthRatio(2));
    }];
    [self.jieSuanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(WidthRatio(126));
    }];
    
    [self layoutIfNeeded];
    [_selectAllBtn setImagePosition:ZCImagePositionLeft spacing:WidthRatio(10)];
    [self.jieSuanButton setImagePosition:ZCImagePositionRight spacing:WidthRatio(10)];

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)selectAllButtonAction:(UIButton *)button {
    if (self.viewModel.cartDatas.count<2) return;
    
    BOOL selected = ![self.viewModel.selectAll boolValue];
    
    self.viewModel.selectAll = [NSNumber numberWithBool:selected];
    [self.viewModel.cartDatas enumerateObjectsUsingBlock:^(__kindof ZCCartModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if(!([model.shop_name isEqualToString:@"推荐商品"] || [model.shop_name isEqualToString:@"失效商品"]))  {
            
            model.selectAll = selected;
            for (ZCPublicGoodsModel *goods in model.shop_goods) {
                goods.selected = selected;
            }
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
    
}

- (void)jieSuanButtonAction:(UIButton *)button {
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    if (info.asstoken) {
        
        NSDictionary *dic = @{@"type":@"1",@"buy_car_ids":self.viewModel.jieSuanCartIds};
        ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"ensure-order" parameters:dic];
        [[self viewController].navigationController pushViewController:webVC animated:YES];
    }else {
        ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
        [[self viewController] presentViewController:loginVC animated:YES completion:nil];
    }
}



#pragma mark - setter && getter
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
    }
    return _countLabel;
}

- (UIButton *)selectAllBtn {
    if (!_selectAllBtn) {
        _selectAllBtn = [UITool richButton:UIButtonTypeCustom title:@"全选" titleColor:ImportantColor font:SystemFont(WidthRatio(14)) bgColor:[UIColor clearColor] image:ImageNamed(@"cart_gods_normal")];
        [_selectAllBtn setImage:ImageNamed(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectAllBtn addTarget:self action:@selector(selectAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)jieSuanButton {
    if (!_jieSuanButton) {
        _jieSuanButton = [UITool richButton:UIButtonTypeCustom title:@"去结算" titleColor:[UIColor whiteColor] font:MediumFont(WidthRatio(17)) bgColor:GeneralRedColor image:ImageNamed(@"cart_jiesuan_arrow")];
        [_jieSuanButton setBackgroundImage:[UIImage imageWithColor:GeneralRedColor] forState:UIControlStateNormal];
        [_jieSuanButton setBackgroundImage:[UIImage imageWithColor:AssistColor] forState:UIControlStateDisabled];
        [_jieSuanButton addTarget:self action:@selector(jieSuanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jieSuanButton;
}


@end
