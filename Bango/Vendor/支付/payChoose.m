//
//  payChoose.m
//  ShanDianPaoTui
//
//  Created by 张海彬 on 2017/11/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "payChoose.h"
#import "MobilePaymentManager.h"
static CGFloat PayAnimationTime = 0.25;

@interface payChoose()
{
    UIButton *aliPayBtn;
    UIButton *weChatBtn;
    
}
@property (nonatomic, strong) UIButton *sureButton;        /** 确认按钮 */
@property (nonatomic, strong) UIButton *canselButton;      /** 取消按钮 */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UIView *bgView;              /** 背景view */
@property (nonatomic, strong) UILabel *titleLabel;          /** 标题Label */
@property (nonatomic,assign)  PayManagerType payType;
@end

@implementation payChoose
+(payChoose *)showPayChooseViewOrderDict:(NSDictionary *)orderData payTheCallback:(void (^) (BOOL isPaySucceed))payTheCallback{
    payChoose *payView = [[payChoose alloc]init];
//    payView.orderID = orderID;
    payView.orderData = orderData;
    payView.payTheCallback = payTheCallback;
    [[UIApplication sharedApplication].keyWindow addSubview:payView];
    return payView;
}
// init 会调用 initWithFrame
- (instancetype)init{
    if (self = [super init]) {
//        [self initWithUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX).offset(0);
        make.top.mas_equalTo(self.bgView.mas_top).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(36));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    [self.bgView addSubview:self.canselButton];
    [self.canselButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(HeightRatio(30));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-HeightRatio(30));
        make.width.height.mas_equalTo(WidthRatio(40));
    }];
    
#pragma mark =====支付宝支付布局=====
    UIImageView *aliPayImageView = [UIImageView new];
    aliPayImageView.image = [UIImage imageNamed:@"alipay"];
    [self.bgView addSubview:aliPayImageView];
    [aliPayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WidthRatio(73));
        make.left.mas_equalTo(self.bgView.mas_left).offset(WidthRatio(75));
        make.top.mas_equalTo(self.bgView.mas_top).offset(HeightRatio(134));
    }];
    UILabel *aliPayLabel = [UILabel new];
    aliPayLabel.font = [UIFont systemFontOfSize:HeightRatio(32)];
    aliPayLabel.textColor = HEX_COLOR(0x121212);
    aliPayLabel.textAlignment = NSTextAlignmentCenter;
    aliPayLabel.text = @"支付宝";
    [self.bgView addSubview:aliPayLabel];
    [aliPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aliPayImageView.mas_right).offset(WidthRatio(43));
        make.centerY.mas_equalTo(aliPayImageView.mas_centerY).offset(0);
        make.height.mas_equalTo(HeightRatio(32));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    aliPayBtn = [UIButton new];
    aliPayBtn.tag = -111;
    [aliPayBtn setImage:[UIImage imageNamed:@"unchoose"] forState:(UIControlStateNormal)];
    [aliPayBtn setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateSelected)];
    aliPayBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [aliPayBtn addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    aliPayBtn.selected = YES;
    _payType = AliPayType;
    [self.bgView addSubview:aliPayBtn];
    [aliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(aliPayImageView.mas_centerY).offset(0);
        make.width.height.mas_equalTo(HeightRatio(60));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-WidthRatio(75));
    }];
#pragma mark ====分割线====
    UILabel *lin = [UILabel new];
    lin.backgroundColor =HEX_COLOR(0xeeeeee);
    [self.bgView addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(WidthRatio(75));
        make.top.mas_equalTo(aliPayImageView.mas_bottom).offset(HeightRatio(38));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-WidthRatio(75));
        make.height.mas_equalTo(1);
    }];
#pragma mark =====微信支付布局=====
    UIImageView *weChatPayImageView = [UIImageView new];
    weChatPayImageView.image = [UIImage imageNamed:@"wechat"];
    [self.bgView addSubview:weChatPayImageView];
    [weChatPayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(WidthRatio(73));
        make.left.mas_equalTo(self.bgView.mas_left).offset(WidthRatio(75));
        make.top.mas_equalTo(lin.mas_bottom).offset(HeightRatio(37));
    }];
    UILabel *weChatPayLabel = [UILabel new];
    weChatPayLabel.font = [UIFont systemFontOfSize:HeightRatio(32)];
    weChatPayLabel.textColor = HEX_COLOR(0x121212);
    weChatPayLabel.textAlignment = NSTextAlignmentCenter;
    weChatPayLabel.text = @"微信支付";
    [self.bgView addSubview:weChatPayLabel];
    [weChatPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weChatPayImageView.mas_right).offset(WidthRatio(43));
        make.centerY.mas_equalTo(weChatPayImageView.mas_centerY).offset(0);
        make.height.mas_equalTo(HeightRatio(32));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    weChatBtn = [UIButton new];
    weChatBtn.tag = -222;
    [weChatBtn setImage:[UIImage imageNamed:@"unchoose"] forState:(UIControlStateNormal)];
    [weChatBtn setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateSelected)];
     weChatBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [weChatBtn addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:weChatBtn];
    [weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weChatPayImageView.mas_centerY).offset(0);
        make.width.height.mas_equalTo(HeightRatio(60));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-WidthRatio(75));
    }];
    
#pragma mark ====去支付====
    UIButton *payButton = [UIButton new];
//    payButton.backgroundColor =HEX_COLOR(0xff2e63);
    payButton.backgroundColor = HEX_COLOR(0xdc5662);
    [payButton setTitle:@"支付" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:HeightRatio(32)];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(toPayForBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(WidthRatio(30));
        make.right.mas_equalTo(self.bgView.mas_right).offset(-WidthRatio(30));
        make.top.mas_equalTo(weChatPayImageView.mas_bottom).offset(HeightRatio(40));
        make.height.mas_equalTo(HeightRatio(98));
    }];
    [payButton.layer setMasksToBounds:YES];
    [payButton.layer setCornerRadius:3.0]; //设置矩圆角半径
//    [payButton.layer setBorderWidth:1.0];   //边框宽度
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 221/255.0, 221/255.0, 221/255.0, 1 });
//    [payButton.layer setBorderColor:colorref];
    [self showPickView];
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, HeightRatio(517))];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:HeightRatio(36)];
        _titleLabel.textColor = HEX_COLOR(0x121212);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"付款详情";
    }
    return _titleLabel;
}
- (UIButton *)canselButton{
    if (!_canselButton) {
        _canselButton = [[UIButton alloc]init];
        [_canselButton setImage:[UIImage imageNamed:@"mallclose"] forState:(UIControlStateNormal)];
        [_canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
         _canselButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _canselButton;
}
-(void)canselButtonClick{
    [self hidePickView];
}
-(void)payButtonClick:(UIButton *)payBtn{
    payBtn.selected = YES;
    if (payBtn == aliPayBtn) {
        _payType = AliPayType;
        weChatBtn.selected = NO;
    }else{
        _payType = WXPayType;
        aliPayBtn.selected = NO;
    }
}
-(void)toPayForBtnClick:(UIButton *)payBtn{
    payBtn.userInteractionEnabled = NO;
//    NSString *OrderName = @"支付宝";
//    NSString *OrderDescription = @"支付宝支付";
    if (_payType == AliPayType) {
//        OrderName = @"支付宝";
//        OrderDescription = @"支付宝支付";
        [[MobilePaymentManager sharedManager]AlipayPaycompleteParams:self.orderData payFinish:^(int code)  {
            payBtn.userInteractionEnabled = YES;
            BOOL isPaySucceed = YES;
           
            switch (code) {
                case 9000:
                {
                    isPaySucceed = YES;
                    // 支付成功
                    [WXZTipView showCenterWithText:@"支付成功"];
                    
                }
                    break;
                    
                case 8000:
                {
                    isPaySucceed = NO;
                    // 取消支付
                    [WXZTipView showCenterWithText:@"支付正在处理"];
           
                    
                }
                    break;
                case 4000:
                {
                    isPaySucceed = NO;
                    // 取消支付
                    [WXZTipView showCenterWithText:@"订单支付失败"];
                    
                }
                    break;
                case 6001:
                {
                     isPaySucceed = NO;
                    // 取消支付
                     [WXZTipView showCenterWithText:@"取消支付"];
                    
                }
                    break;
                case 6002:
                {
                    isPaySucceed = NO;
                    // 取消支付
                    [WXZTipView showCenterWithText:@"网络连接出错"];
                    
                }
                    break;
                    
                default:
                {
                    isPaySucceed = NO;
                    // 支付失败
                    [WXZTipView showCenterWithText:@"支付失败"];
                    
                }
                    break;
            }
            if (self.payTheCallback) {
                self.payTheCallback(isPaySucceed);
            }
        }];
        
    }else{
//        OrderName = @"微信";
//        OrderDescription = @"微信支付";
        [[MobilePaymentManager sharedManager] wechatPayWithParams:self.orderData  finish:^(int respCode) {
            payBtn.userInteractionEnabled = YES;
            BOOL isPaySucceed = YES;
            switch (respCode) {
                case WXSuccess:
                {
                    isPaySucceed = YES;
                    // 支付成功
                    [WXZTipView showCenterWithText:@"支付成功"];
                }
                    break;
                    
                case WXErrCodeUserCancel:
                {
                     isPaySucceed = NO;
                    // 取消支付
                    
                     [WXZTipView showCenterWithText:@"用户取消支付"];
                }
                    break;
                    
                default:
                {
                     isPaySucceed = NO;
                    // 支付失败
                    [WXZTipView showCenterWithText:@"支付失败"];
                    
                }
                    break;
            }
            if (self.payTheCallback) {
                self.payTheCallback(isPaySucceed);
            }
        }];
    }
      [self hidePickView];

}
#pragma mark  ====展示View====
- (void)showPickView{
    [UIView animateWithDuration:PayAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - HeightRatio(517)-HomeIndicatorHeight, self.frame.size.width, HeightRatio(517));
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark  ====隐藏View====
- (void)hidePickView{
    
    [UIView animateWithDuration:PayAnimationTime animations:^{
        
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, HeightRatio(517));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
