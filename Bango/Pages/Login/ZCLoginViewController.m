//
//  ZCLoginViewController.m
//  Bango
//
//  Created by zchao on 2019/3/14.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCLoginViewController.h"
#import "ZCLoginViewModel.h"
#import "JKCountDownButton.h"
#import "ZCFallingAnimationView.h"

@interface ZCLoginViewController ()

@property(nonatomic, strong) ZCLoginViewModel *viewModel;

@property(nonatomic, strong) ZCFallingAnimationView *failingBtnView;

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, strong) UITextField *phoneNumberField;

@property(nonatomic, strong) UITextField *authCodeField;

@end

@implementation ZCLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.completeBackToHome = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessComplete:) name:loginSuccessNotification object:nil];
}

- (void)loginSuccessComplete:(NSNotification *)notif {
    NSLog(@"notif_userInfo:%@", notif.userInfo);

//    [self dismissViewControllerAnimated:YES completion:^{
//        //保存用户登录信息
//        UserInfoModel *model = [notif.userInfo objectForKey:@"userModel"];
//        [BaseMethod saveObject:model withKey:UserInfo_UDSKEY];
//        [self.viewModel.personDataCmd execute:nil];
//    }];
//    if (self.loginCallback) {
//        self.loginCallback([notif.userInfo objectForKey:@"userResp"]);
//    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}




- (void)configCustomNav {
    [super setupNavBar];
    self.customNavBar.title = @"登录";
    [self.customNavBar wr_setLeftButtonWithImage:ImageNamed(@"close")];
    [self.customNavBar wr_setBottomLineHidden:YES];
}

- (void)configViews {
    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [UITool imageViewImage:ImageNamed(@"login_illustration") contentMode:UIViewContentModeScaleAspectFill];

    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(WidthRatio(30));
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(imgView.mas_top);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
    
    UIView *normalContent = [self setupNormalLoginContentView];
    UIView *fastContent = [self setupFastLoginContentView];
    
    [RACObserve(self.viewModel, loginType) subscribeNext:^(NSString * _Nullable x) {
        normalContent.hidden = ![x isEqualToString:@"2"];
        fastContent.hidden = [x isEqualToString:@"2"];
    }];
    
    self.failingBtnView = [[ZCFallingAnimationView alloc] initWithFrame:CGRectMake(0, topDiff, SCREEN_WIDTH, SCREEN_HEIGHT-topDiff)];
}


- (void)executeLoginCmd {
    [[self.viewModel.phoneCmd execute:@{@"username":self.phoneNumberField.text,@"send_param":self.authCodeField.text}] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
}


- (void)executeAuthCmd {
    
    [[self.viewModel.authCodeCmd execute:@{@"phone_number":self.phoneNumberField.text,@"sendstatus":@"3"}] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void)bindViewModel {
    
    @weakify(self);
    [RACObserve(self, viewModel.userResp) subscribeNext:^(id _Nullable userResp) {
        @strongify(self);
        if (userResp) {
            [self dismissViewControllerAnimated:YES completion:^{
                
                if (self->_completeBackToHome) {
                    UINavigationController *rootNav =  (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
                    UITabBarController *tabBarVC = (UITabBarController *)rootNav.topViewController;
                    [tabBarVC setSelectedIndex:0];
                }
            }];
        }
    }];
    
    
    
    
    //phoneLogin
    //    [[self.viewModel.phoneCmd executionSignals] subscribeNext:^(id  _Nullable x) {
    //
    //    }];
    //
    //    //zhifubaoLogin
    //    [[self.viewModel.zhifubaoCmd executionSignals] subscribeNext:^(id  _Nullable x) {
    //    }];
    //
    //    //wechatLogin
    //    [[self.viewModel.wechatCmd executionSignals] subscribeNext:^(id  _Nullable x) {
    //
    //    }];
    
}

- (void)authCodeBtnAction:(JKCountDownButton*)button {
    if (![self.phoneNumberField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    
    
    [self executeAuthCmd];
    
    [button startCountDownWithSecond:60];
    [button countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        button.enabled = NO;
        button.layer.borderColor = [HEX_COLOR(0xFC5E62) CGColor];
        return [NSString stringWithFormat:@"重新发送(%zd)", second];
    }];
    [button countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        button.enabled = YES;
        button.layer.borderColor = [AssistColor CGColor];
        return @"获取验证码";
    }];
}

- (void)agreeButtonAction:(UIButton *)button {
    button.selected = !button.selected;
}

- (void)loginAction:(UIButton *)button {
    [self executeLoginCmd];
}

// 切换到手机号吗登录
- (void)switchToPhoneLoginAction:(UIButton *)button {
    self.viewModel.loginType = @"2";
    self.viewModel.loginBtnTitle = @"登录";
}


- (UIView *)setupFastLoginContentView {
    //快速登陆
    UIView *fastContentView = [UIView new];
    UserInfoModel *model = [BaseMethod readObjectWithKey:UserInfo_UDSKEY];
    UIImageView *portraitView = [UITool imageViewImage:model.avatar placeHolder:ImageNamed(@"placeHolder") contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(37) borderWidth:0 borderColor:[UIColor clearColor]];

    UIButton *loginButton = [UITool wordButton:self.viewModel.loginBtnTitle titleColor:[UIColor whiteColor] font:MediumFont(17) bgColor:HEX_COLOR(0xFD1617)];
    MMViewBorderRadius(loginButton, WidthRatio(22), 0, [UIColor clearColor]);
    
    UIButton *agreeButton = [UITool richButton:UIButtonTypeCustom title:@" 我已阅读同意" titleColor:AssistColor font:MediumFont(14) bgColor:[UIColor clearColor] image:ImageNamed(@"login_disagree")];
    [agreeButton setImage:ImageNamed(@"login_agree") forState:UIControlStateSelected];
    agreeButton.selected = YES;
    [agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *policyButton = [UITool wordButton:@"《服务条款与隐私政策》" titleColor:RGBA(252, 83, 87, 1) font:MediumFont(14) bgColor:[UIColor clearColor]];
    UILabel *otherLoginLab = [UITool labelWithText:@"  快速登录  " textColor:AssistColor font:MediumFont(14)];
    otherLoginLab.backgroundColor = [UIColor whiteColor];
    UIView *bottomLine = [UITool viewWithColor:LineColor];
    UIButton *thirdBtn = [UITool imageButton:self.viewModel.loginType.intValue?ImageNamed(@"login_wechat"): ImageNamed(@"login_zhifubao")];
    UIButton *phoneBtn = [UITool imageButton:ImageNamed(@"login_phone")];
    [phoneBtn addTarget:self action:@selector(switchToPhoneLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.viewModel.loginType.intValue) {
        loginButton.rac_command = self.viewModel.zhifubaoCmd;
        thirdBtn.rac_command = self.viewModel.wechatCmd;
    }else {
        loginButton.rac_command = self.viewModel.wechatCmd;
        thirdBtn.rac_command = self.viewModel.zhifubaoCmd;
    }
    
    [self.scrollView addSubview:fastContentView];
    [fastContentView addSubview:portraitView];
    [fastContentView addSubview:loginButton];
    [fastContentView addSubview:agreeButton];
    [fastContentView addSubview:policyButton];
    [fastContentView addSubview:bottomLine];
    [fastContentView addSubview:otherLoginLab];
    [fastContentView addSubview:thirdBtn];
    [fastContentView addSubview:phoneBtn];
    
    [fastContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fastContentView);
        make.top.equalTo(fastContentView).inset(WidthRatio(60));
        make.size.mas_equalTo(CGSizeMake(WidthRatio(74), WidthRatio(74)));
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(portraitView.mas_bottom).offset(WidthRatio(60));
        make.left.right.equalTo(fastContentView).inset(50);
        make.height.mas_equalTo(WidthRatio(44));
    }];
    
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fastContentView).inset(WidthRatio(56));
        make.top.equalTo(loginButton.mas_bottom).offset(WidthRatio(16));
        make.height.mas_equalTo(WidthRatio(29));
    }];
    
    [policyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(fastContentView).inset(WidthRatio(56));
        make.centerY.equalTo(agreeButton);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(fastContentView).inset(WidthRatio(116));
        make.height.mas_equalTo(0.5);
        make.top.equalTo(agreeButton.mas_bottom).offset(WidthRatio(140));
    }];
    
    [otherLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomLine);
    }];
    
    [thirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(WidthRatio(20));
        make.right.equalTo(fastContentView.mas_centerX).offset(-WidthRatio(27));
        make.bottom.equalTo(fastContentView).inset(WidthRatio(20));
    }];
    
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdBtn);
        make.left.equalTo(fastContentView.mas_centerX).offset(WidthRatio(27));
    }];

    return fastContentView;
}

// 普通登录
- (UIView *) setupNormalLoginContentView {
    
    self.contentView = [UIView new];
    self.phoneNumberField = [UITool textField:@"请输入手机号码(+86)" textColor:AssistColor font:MediumFont(15) borderStyle:UITextBorderStyleNone];
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    UIView *lineView1 = [UITool viewWithColor:LineColor];
    self.authCodeField = [UITool textField:@"请输入验证码" textColor:AssistColor font:MediumFont(15) borderStyle:UITextBorderStyleNone];
    self.authCodeField.keyboardType = UIKeyboardTypeNumberPad;
    UIView *lineView2 = [UITool viewWithColor:LineColor];
    
    JKCountDownButton *authCodeBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    authCodeBtn.titleLabel.font = MediumFont(12);
    [authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [authCodeBtn setTitleColor:AssistColor forState:UIControlStateNormal];
    [authCodeBtn setTitleColor:HEX_COLOR(0xFC5E62) forState:UIControlStateDisabled];
    authCodeBtn.backgroundColor = [UIColor whiteColor];
    
    [authCodeBtn addTarget:self action:@selector(authCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    MMViewBorderRadius(authCodeBtn, WidthRatio(13), 0.5, AssistColor);
    
    UIButton *loginButton = [UITool wordButton:@"登录" titleColor:[UIColor whiteColor] font:MediumFont(17) bgColor:[UIColor whiteColor]];
    [loginButton setBackgroundImage:[BaseMethod createImageWithColor:HEX_COLOR(0xFC5E62)] forState:UIControlStateDisabled];
    [loginButton setBackgroundImage:[BaseMethod createImageWithColor:HEX_COLOR(0xFD1617)] forState:UIControlStateNormal];
    MMViewBorderRadius(loginButton, WidthRatio(22), 0, [UIColor clearColor]);
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *agreeButton = [UITool richButton:UIButtonTypeCustom title:@" 我已阅读同意" titleColor:AssistColor font:MediumFont(14) bgColor:[UIColor clearColor] image:ImageNamed(@"login_disagree")];
    [agreeButton setImage:ImageNamed(@"login_agree") forState:UIControlStateSelected];
    agreeButton.selected = YES;
    [agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *policyButton = [UITool wordButton:@"《服务条款与隐私政策》" titleColor:RGBA(252, 83, 87, 1) font:MediumFont(14) bgColor:[UIColor clearColor]];
    UIView *bottomLine = [UITool viewWithColor:LineColor];
    UILabel *fastLoginLab = [UITool labelWithText:@"  快速登录  " textColor:AssistColor font:MediumFont(14)];
    fastLoginLab.backgroundColor = [UIColor whiteColor];
    UIButton *zhifubaoBtn = [UITool imageButton:ImageNamed(@"login_zhifubao")];
    UIButton *wechatBtn = [UITool imageButton:ImageNamed(@"login_wechat")];
    
    @weakify(self);
    RAC(loginButton, enabled) = [RACSignal combineLatest:@[self.authCodeField.rac_textSignal, self.phoneNumberField.rac_textSignal] reduce:^(NSString *authCode, NSString *phoneNumber){
        @strongify(self);
        return @(authCode.length > 0 && [self.phoneNumberField.text isValidateMobile]);
    }];
    
    RAC(self.viewModel,phoneNumber) = RACObserve(self.phoneNumberField, text);
    RAC(self.viewModel,authCodeString) = RACObserve(self.authCodeField, text);

    zhifubaoBtn.rac_command = self.viewModel.zhifubaoCmd;
    wechatBtn.rac_command = self.viewModel.wechatCmd;
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.phoneNumberField];
    [self.contentView addSubview:lineView1];
    [self.contentView addSubview:self.authCodeField];
    [self.contentView addSubview:lineView2];
    [self.contentView addSubview:authCodeBtn];
    [self.contentView addSubview:loginButton];
    [self.contentView addSubview:agreeButton];
    [self.contentView addSubview:policyButton];
    [self.contentView addSubview:bottomLine];
    [self.contentView addSubview:fastLoginLab];
    [self.contentView addSubview:zhifubaoBtn];
    [self.contentView addSubview:wechatBtn];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.view);
    }];
    
    [self.phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(WidthRatio(50));
        make.top.equalTo(self.contentView).inset(WidthRatio(60));
    }];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneNumberField );
        make.top.equalTo(self.phoneNumberField.mas_bottom).offset(WidthRatio(10));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.authCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneNumberField);
        make.top.equalTo(lineView1.mas_bottom).offset(WidthRatio(35));
        make.right.equalTo(authCodeBtn.mas_left);
    }];
    
    [authCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.authCodeField);
        make.right.equalTo(self.phoneNumberField);
        make.size.mas_equalTo(CGSizeMake(WidthRatio(90), WidthRatio(25)));
    }];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneNumberField);
        make.top.equalTo(self.authCodeField.mas_bottom).offset(HeightRatio(10));
        make.height.mas_equalTo(0.5);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneNumberField);
        make.top.equalTo(lineView2.mas_bottom).offset(WidthRatio(40));
        make.height.mas_equalTo(WidthRatio(44));
    }];
    
    [agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(WidthRatio(56));
        make.top.equalTo(loginButton.mas_bottom).offset(WidthRatio(16));
        make.height.mas_equalTo(WidthRatio(29));
    }];
    
    [policyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(WidthRatio(56));
        make.centerY.equalTo(agreeButton);
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(WidthRatio(116));
        make.height.mas_equalTo(0.5);
        make.top.equalTo(agreeButton.mas_bottom).offset(WidthRatio(140));
    }];
    
    [fastLoginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomLine);
    }];
    
    [zhifubaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLine.mas_bottom).offset(WidthRatio(20));
        make.right.equalTo(self.contentView.mas_centerX).offset(-WidthRatio(27));
        make.bottom.equalTo(self.contentView).inset(WidthRatio(20));
    }];
    
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhifubaoBtn);
        make.left.equalTo(self.contentView.mas_centerX).offset(WidthRatio(27));
    }];
    
    return self.contentView;
}

#pragma mark - setter && getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (ZCLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [ZCLoginViewModel new];
    }
    return _viewModel;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:loginSuccessNotification object:nil];
    
    [self.failingBtnView removeFromSuperview];
    
}

@end
