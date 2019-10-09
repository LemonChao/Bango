//
//  ZCPersonalwelfareCell.m
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalwelfareCell.h"

@interface ZCWelfareButton : UIControl

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *descriptLabel;

@end


@interface ZCPersonalwelfareCell ()
@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong) UIButton *leftButton;

@property(nonatomic, strong) UIButton *rightButton;

@property(nonatomic, strong) ZCWelfareButton *powerView;

@property(nonatomic, strong) ZCWelfareButton *guoguoView;
@property(nonatomic, strong) UIView *topBgView;
@end


@implementation ZCPersonalwelfareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bgView = [UITool viewWithColor:[UIColor whiteColor]];
        bgView.clipsToBounds = YES;
        UIView *lineView = [UITool viewWithColor:LineColor];
        UIView *guoBgView = [UITool viewWithColor:[UIColor whiteColor]];
        [self.contentView addSubview:bgView];
        [bgView addSubview:self.titleLable];
        [bgView addSubview:lineView];
        [bgView addSubview:self.powerView];
        [bgView addSubview:guoBgView];
        self.topBgView = bgView;
        [bgView addSubview:self.guoguoView];

        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        
//        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), WidthRatio(98+14)+1, WidthRatio(12)));
//        }];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView).inset(WidthRatio(12));
            make.height.mas_equalTo(WidthRatio(40));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).inset(WidthRatio(10));
            make.top.equalTo(bgView);
            make.height.mas_equalTo(WidthRatio(40));
        }];

        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(bgView).inset(WidthRatio(40));
            make.top.equalTo(self.titleLable.mas_bottom);
            make.left.right.equalTo(bgView);
            make.height.mas_equalTo(1);
        }];
        
        [self.guoguoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).inset(WidthRatio(10));
            make.top.equalTo(self.titleLable.mas_bottom).offset(WidthRatio(15));
            make.height.mas_equalTo(WidthRatio(50));
        }];
        
        [self.powerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView).inset(WidthRatio(10));
            make.left.equalTo(self.guoguoView.mas_right);
            make.size.equalTo(self.guoguoView);
            make.top.equalTo(self.guoguoView);
        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).inset(WidthRatio(12));
            make.top.equalTo(bgView.mas_bottom).offset(WidthRatio(8));
            make.height.mas_equalTo(WidthRatio(90));
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).inset(WidthRatio(12));
            make.left.equalTo(self.leftButton.mas_right).offset(WidthRatio(5));
            make.size.equalTo(self.leftButton);
            make.top.equalTo(self.leftButton);
        }];
    }
    return self;
}

- (void)setModel:(ZCPersonalCenterModel *)model {
    _model = model;
    
    [model.platforms enumerateObjectsUsingBlock:^(__kindof ZCPersonalAdvModel * _Nonnull advModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [self.leftButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_image] forState:UIControlStateNormal placeholderImage:ImageNamed(@"personnal_advPlaceholder_left")];
            [self.leftButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_image] forState:UIControlStateHighlighted placeholderImage:ImageNamed(@"personnal_advPlaceholder_left")];
            [self.leftButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_url] forState:UIControlStateSelected];
            
        }else if (idx == 1) {
            [self.rightButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_image] forState:UIControlStateNormal placeholderImage:ImageNamed(@"personnal_advPlaceholder_right")];
            [self.rightButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_image] forState:UIControlStateHighlighted placeholderImage:ImageNamed(@"personnal_advPlaceholder_right")];
            [self.rightButton sd_setImageWithURL:[NSURL URLWithString:advModel.adv_url] forState:UIControlStateSelected];
        }
    }];
    
    [self.topBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([model.guo_open boolValue]?WidthRatio(120):WidthRatio(40));
    }];
}


- (void)leftButtonAction:(UIButton *)button {
    
    NSURL *advUrl = [button sd_imageURLForState:UIControlStateSelected];
    if (!advUrl) return;
    ZCWebViewController *webVC = [[ZCWebViewController alloc] init];
    webVC.urlString = advUrl.absoluteString;
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}
- (void)rightButtonAction:(UIButton *)button {
    NSURL *advUrl = [button sd_imageURLForState:UIControlStateSelected];
    if (!advUrl) return;
    ZCWebViewController *webVC = [[ZCWebViewController alloc] init];
    webVC.urlString = advUrl.absoluteString;
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}


- (void)guoguoViewAction:(ZCWelfareButton *)button {
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"GuoGuoGame" parameters:@{@"asstoken":info.asstoken?:@""}];
    webVC.topInset = 0.f;
    webVC.bottomInset = 0.f;
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}
- (void)powerViewAction:(ZCWelfareButton *)button {
    UserInfoModel *info = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"FruitTreeGame" parameters:@{@"asstoken":info.asstoken?:@""}];
    webVC.topInset = 0.f;
    webVC.bottomInset = 0.f;
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}


#pragma mark - setter && getter

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithText:@"我的福利" textColor:PrimaryColor font:BoldFont(WidthRatio(17))];
    }
    return _titleLable;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UITool imageButton:nil cornerRadius:WidthRatio(9) borderWidth:0 borderColor:[UIColor clearColor]];
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UITool imageButton:nil cornerRadius:WidthRatio(9) borderWidth:0 borderColor:[UIColor clearColor]];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (ZCWelfareButton *)powerView {
    if (!_powerView) {
        _powerView = [[ZCWelfareButton alloc] init];
        _powerView.imgView.image = ImageNamed(@"banguoleyuan");
        _powerView.titleLabel.text = @"种果发酵乐园";
        _powerView.descriptLabel.text = @"玩游戏得商城奖励";
        [_powerView addTarget:self action:@selector(powerViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _powerView;
}

- (ZCWelfareButton *)guoguoView {
    if (!_guoguoView) {
        _guoguoView  = [[ZCWelfareButton alloc] init];
        _guoguoView.imgView.image = ImageNamed(@"personal_guoguo");
        _guoguoView.titleLabel.text = @"摘果大冒险";
        _guoguoView.descriptLabel.text = @"欢乐蹦蹦跳";
        [_guoguoView addTarget:self action:@selector(guoguoViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _guoguoView;
}

@end





@implementation ZCWelfareButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imgView = [UITool imageViewImage:nil contentMode:UIViewContentModeScaleToFill];
        self.titleLabel = [UITool labelWithTextColor:ImportantColor font:MediumFont(WidthRatio(14))];
        self.descriptLabel = [UITool labelWithTextColor:AssistColor font:MediumFont(WidthRatio(11))];
        
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descriptLabel];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(self.imgView.mas_height);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(WidthRatio(10));
            make.right.equalTo(self);
            make.bottom.equalTo(self.imgView.mas_centerY).inset(WidthRatio(3));
        }];
        
        [self.descriptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(WidthRatio(10));
            make.right.equalTo(self);
            make.top.equalTo(self.imgView.mas_centerY).offset(WidthRatio(3));
        }];
        
    }
    return self;
}


@end
