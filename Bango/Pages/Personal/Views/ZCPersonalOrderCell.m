//
//  ZCPersonalOrderCell.m
//  Bango
//
//  Created by zchao on 2019/4/8.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalOrderCell.h"
#import "UIButton+EdgeInsets.h"
#import "UIimage+Developer.h"

@class ZCBadgeButton;
@interface ZCBadgeLabel : UILabel

@property(nullable, nonatomic, copy) NSString *badgeValue;    // default is nil

@end

@interface ZCPersonalOrderCell ()

@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong) UIButton *allButton;

@property(nonatomic, strong) UIStackView *stack;

@property(nonatomic, copy) NSArray<__kindof ZCBadgeButton*> *subButtons;

@end

@implementation ZCPersonalOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *bgView = [UITool viewWithColor:[UIColor whiteColor]];
        UIView *lineView = [UITool viewWithColor:LineColor];
        self.stack = [[UIStackView alloc] initWithArrangedSubviews:self.subButtons];
        self.stack.axis = UILayoutConstraintAxisHorizontal;
        self.stack.distribution = UIStackViewDistributionFillEqually;
        self.stack.alignment = UIStackViewAlignmentFill;
        self.stack.spacing = WidthRatio(40);
        
        [self.contentView addSubview:bgView];
        [bgView addSubview:self.titleLable];
        [bgView addSubview:self.allButton];
        [bgView addSubview:lineView];
        [bgView addSubview:self.stack];

        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), 0, WidthRatio(12)));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).inset(WidthRatio(10));
            make.top.equalTo(bgView).inset(WidthRatio(14));
        }];
        
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLable);
            make.right.equalTo(bgView).inset(WidthRatio(15));
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).inset(WidthRatio(40));
            make.left.right.equalTo(bgView);
            make.height.mas_equalTo(1);
        }];
        
        [self.stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(bgView).inset(WidthRatio(15));
            make.top.equalTo(lineView.mas_bottom).offset(WidthRatio(20));
            make.bottom.equalTo(bgView).inset(WidthRatio(20));
        }];
    }
    
    return self;
}

- (void)setModel:(ZCPersonalCenterModel *)model {
//    if (!model) return;
    _model = model;
    [self.subButtons enumerateObjectsUsingBlock:^(__kindof ZCBadgeButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                button.badgeValue = model.pay_ords;
                break;
            case 1:
                button.badgeValue = model.fa_ords;
                break;
            case 2:
                button.badgeValue = model.shou_ords;
                break;
            case 3:
                button.badgeValue = model.virtual_wait_evaluate;
                break;

            default:
                break;
        }
    }];
    
    
}

- (NSArray<ZCBadgeButton *> *)subButtons {
    
    if (!_subButtons) {
        NSArray *titls = @[@"待付款",@"待发货",@"待收货",@"待评价"];
        NSArray *imageNames = @[@"personal_pay",@"personal_shipments",@"personal_receiving",@"personal_comment"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < titls.count; i++) {
            ZCBadgeButton *button = [[ZCBadgeButton alloc] initWithImage:ImageNamed(imageNames[i]) title:titls[i] badge:@"0"];
            [button addTarget:self action:@selector(badgeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        _subButtons = array.copy;
    }
    
    return _subButtons;
}

- (void)badgeButtonAction:(ZCBadgeButton *)button {
    
    NSString *index = StringFormat(@"%ld",[self.subButtons indexOfObject:button]);
    
    NSDictionary *dic = @{@"current_tab":index};
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"my-order" parameters:dic];
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}
- (void)allButtonAction:(ZCBadgeButton *)button {
    NSDictionary *dic = @{@"current_tab":@"all"};
    ZCWebViewController *webVC = [[ZCWebViewController alloc] initWithPath:@"my-order" parameters:dic];
    [[self viewController].navigationController pushViewController:webVC animated:YES];
}


#pragma mark - setter && getter

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithText:@"我的订单" textColor:PrimaryColor font:BoldFont(WidthRatio(17))];
    }
    return _titleLable;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UITool richButton:UIButtonTypeCustom title:@"查看全部订单" titleColor:AssistColor font:MediumFont(WidthRatio(12)) bgColor:[UIColor clearColor] image:[[UIImage imageNamed:@"home_arrow_right"] redrawImageWithColor:AssistColor]];
        CGSize size = [_allButton sizeThatFits:CGSizeZero];
        _allButton.frame = CGRectMake(0, 0, size.width, size.height);
        [_allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.allButton setImagePosition:ZCImagePositionRight spacing:WidthRatio(9)];
    }
    return _allButton;
}



@end



@implementation ZCBadgeLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:11];
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 6.f;
        self.clipsToBounds = YES;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];

    if (self.badgeValue.integerValue <= 0) return CGSizeZero;
    
    if (self.badgeValue.integerValue < 10) {
        return CGSizeMake(12, 12);
    }else {
        return CGSizeMake(size.width+8, 12);
    }
}


- (void)setBadgeValue:(NSString *)badgeValue {
    if (_badgeValue == badgeValue || [_badgeValue isEqual:badgeValue]) return;
    
    _badgeValue = badgeValue;
    self.text = _badgeValue;
}

@end



@interface ZCBadgeButton ()

@property(nullable, nonatomic, strong) UIImageView *imgView;

@property(nullable, nonatomic, strong) UILabel *titleLab;

@property(nullable, nonatomic, strong) ZCBadgeLabel *badgeLab;

@end

@implementation ZCBadgeButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title badge:(NSString *)badge {
    
    self = [super init];
    if (self) {
        [self commonInit];
        self.imgView.image = image;
        self.titleLab.text = title;
        self.badgeLab.badgeValue = badge;
    }
    return self;
}

- (void)commonInit {
    self.imgView = [[UIImageView alloc] init];
    self.titleLab = [UITool labelWithTextColor:ImportantColor font:[UIFont systemFontOfSize:WidthRatio(14)] alignment:NSTextAlignmentCenter];
    self.badgeLab = [[ZCBadgeLabel alloc] init];
    
    [self addSubview:self.imgView];
    [self addSubview:self.titleLab];
    [self addSubview:self.badgeLab];
    
}

- (void)updateConstraints {
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.badgeLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [super updateConstraints];
}


- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imgView.image = image;
    [self setNeedsUpdateConstraints];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.titleLab setText:title];
    [self setNeedsUpdateConstraints];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = badgeValue;
    
    self.badgeLab.badgeValue = badgeValue;
    [self setNeedsUpdateConstraints];
}

@end
