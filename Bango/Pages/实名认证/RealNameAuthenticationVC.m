//
//  RealNameAuthenticationVC.m
//  GCT
//
//  Created by 张海彬 on 2018/9/5.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "RealNameAuthenticationVC.h"
#import "LayoutMacro.h"
#import "ToolMacro.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "UIViewController+LKBubbleView.h"
#import "UIImage+Developer.h"
#import "UIButton+EdgeInsets.h"
#import <Masonry/Masonry.h>
#import "AVCaptureViewController.h"
#import "JQAVCaptureViewController.h"
#import "HXPhotoPicker.h"
#import "NSString+Helper.h"
#import "NetWorkHelper.h"
@interface RealNameAuthenticationVC ()<HXAlbumListViewControllerDelegate>
{
    UIView *oneView;
    UIView *twoView;
    UIView *rulesView;
    UIView *informationView;
    /** 签名照片*/
    UIImage *signatureImage;
    /** 正面照*/
    UIImage *idCardPositiveImage;
    /** 反面照*/
    UIImage *idCardBackImage;
    
    UIImageView *signatureImageView;
    UIImageView *idCardPositiveImageView;
    UIImageView *idCardBackImageView;
        //地址
    NSString *address;
    
    
    /** 正面照按钮*/
    UIButton *positiveBtn;
    /** 反面照按钮*/
    UIButton *reverseeBtn;
    /** 手照按钮*/
    UIButton *handheldBtn;
    
    UIButton *button;
}
@property (nonatomic,strong)UIView *navigationBarView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *idCardTextField;

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;

@end

@implementation RealNameAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实名认证";
    [self setNavigationBar];
    [self setContentView];
    [self initWithUI];
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
-(void)setContentView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.navigationBarView.height, SCREEN_WIDTH, self.view.height - self.navigationBarView.height)];
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.bounces = NO;
    self.scrollView.backgroundColor = HEX_COLOR(0xe6f0fc);
    [self.view addSubview:self.scrollView];
    
}
-(void)initWithUI{
    [self setOneView];
    [self setTwoView];
    [self setRulesView];
    [self setInformationView];
    
    button = [UIButton new];
    button.userInteractionEnabled = NO; 
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button setBackgroundColor:HEX_COLOR(0xbdc4cf)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(completeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:button];
    button.sd_layout
    .topSpaceToView(informationView, HeightRatio(215))
    .leftSpaceToView(self.scrollView, WidthRatio(30))
    .rightSpaceToView(self.scrollView, WidthRatio(30))
    .heightIs(HeightRatio(91));
    MMViewBorderRadius(button, WidthRatio(50), 0, [UIColor clearColor]);
    [self.scrollView setupAutoContentSizeWithBottomView:button bottomMargin:HeightRatio(96)];
    
}
-(void)setOneView{
    oneView = [UIView new];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:oneView];
    oneView.sd_layout
    .leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topEqualToView(self.scrollView)
    .heightIs(HeightRatio(370));
    
    UIButton *title = [UIButton new];
    title.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [title setImage:MMGetImage(@"*") forState:(UIControlStateNormal)];
    [title setTitle:@"拍摄并上传你的身份证" forState:(UIControlStateNormal)];
    [title setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [title setImagePositionWithType:(ImagePositionTypeLeft) spacing:WidthRatio(28) leftSpacing:0];
    [oneView addSubview:title];
    title.sd_layout
    .leftSpaceToView(oneView, WidthRatio(30))
    .topSpaceToView(oneView, HeightRatio(19))
    .heightIs(HeightRatio(27))
    .widthIs(WidthRatio(335));
    
    positiveBtn = [UIButton new];
    positiveBtn.backgroundColor = [UIColor clearColor];
    [positiveBtn setBackgroundImage:MMGetImage(@"zhengmian")  forState:UIControlStateNormal];
    positiveBtn.contentMode = UIViewContentModeScaleToFill;
    [positiveBtn addTarget:self action:@selector(positiveBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [oneView addSubview:positiveBtn];
    MMViewBorderRadius(positiveBtn, 5, 0, [UIColor clearColor]);
    positiveBtn.sd_layout
    .leftSpaceToView(oneView, WidthRatio(30))
    .topSpaceToView(title, HeightRatio(21))
    .widthIs(WidthRatio(335))
    .heightIs(HeightRatio(287));
    
    idCardPositiveImageView = [UIImageView new];
    idCardPositiveImageView.userInteractionEnabled = NO;
    idCardPositiveImageView.contentMode = UIViewContentModeScaleToFill;
    [positiveBtn addSubview:idCardPositiveImageView];
    idCardPositiveImageView.sd_layout
    .leftSpaceToView(positiveBtn, WidthRatio(32))
    .rightSpaceToView(positiveBtn, WidthRatio(32))
    .topSpaceToView(positiveBtn, HeightRatio(32))
    .heightIs(HeightRatio(164));
    
    
    UILabel *positiveLabel = [UILabel new];
    positiveLabel.text = @"请拍摄正面";
    positiveLabel.backgroundColor = [UIColor clearColor];
    positiveLabel.textAlignment = NSTextAlignmentCenter;
    positiveLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    positiveLabel.textColor = [UIColor whiteColor];
    [positiveBtn addSubview:positiveLabel];
    positiveLabel.sd_layout
    .centerXEqualToView(positiveBtn)
    .bottomSpaceToView(positiveBtn, HeightRatio(16))
    .heightIs(HeightRatio(28))
    .widthIs(WidthRatio(335));
    
    
    reverseeBtn = [UIButton new];
    reverseeBtn.backgroundColor = [UIColor clearColor];
//    [reverseeBtn setImage:MMGetImage(@"fanmian") forState:(UIControlStateNormal)];
    [reverseeBtn setBackgroundImage:MMGetImage(@"fanmian") forState:UIControlStateNormal];
    reverseeBtn.contentMode = UIViewContentModeScaleToFill;
    [reverseeBtn addTarget:self action:@selector(reverseeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [oneView addSubview:reverseeBtn];
     MMViewBorderRadius(reverseeBtn, 5, 0, [UIColor clearColor]);
    reverseeBtn.sd_layout
    .rightSpaceToView(oneView, WidthRatio(30))
    .topSpaceToView(title, HeightRatio(21))
    .widthIs(WidthRatio(335))
    .heightIs(HeightRatio(287));
    
    idCardBackImageView = [UIImageView new];
    idCardBackImageView.userInteractionEnabled = NO;
    idCardBackImageView.contentMode = UIViewContentModeScaleToFill;
    [reverseeBtn addSubview:idCardBackImageView];
//    MMViewBorderRadius(idCardBackImageView, 5, 0, [UIColor clearColor]);
    idCardBackImageView.sd_layout
    .leftSpaceToView(reverseeBtn, WidthRatio(32))
    .rightSpaceToView(reverseeBtn, WidthRatio(32))
    .topSpaceToView(reverseeBtn, HeightRatio(32))
    .heightIs(HeightRatio(164));
    
    UILabel *reverseeLabel = [UILabel new];
    reverseeLabel.text = @"请拍摄反面";
    reverseeLabel.backgroundColor = [UIColor clearColor];
    reverseeLabel.textAlignment = NSTextAlignmentCenter;
    reverseeLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    reverseeLabel.textColor = [UIColor whiteColor];
    [reverseeBtn addSubview:reverseeLabel];
    reverseeLabel.sd_layout
    .centerXEqualToView(reverseeBtn)
    .bottomSpaceToView(reverseeBtn, HeightRatio(16))
    .heightIs(HeightRatio(28))
    .widthIs(WidthRatio(335));
}
-(void)setTwoView{
    twoView = [UIView new];
    twoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:twoView];
    twoView.sd_layout
    .leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topSpaceToView(oneView, HeightRatio(20))
    .heightIs(HeightRatio(374));
    
    UIButton *title = [UIButton new];
    title.userInteractionEnabled = NO;
    title.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [title setImage:MMGetImage(@"*") forState:(UIControlStateNormal)];
    [title setTitle:@"拍摄并上传你的手持身份证" forState:(UIControlStateNormal)];
    [title setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [title setImagePositionWithType:(ImagePositionTypeLeft) spacing:WidthRatio(28) leftSpacing:0];
    [twoView addSubview:title];
    title.sd_layout
    .leftSpaceToView(twoView, WidthRatio(30))
    .topSpaceToView(twoView, HeightRatio(19))
    .heightIs(HeightRatio(27))
    .widthIs(WidthRatio(386));
    
    handheldBtn = [UIButton new];
    handheldBtn.backgroundColor = [UIColor clearColor];
    [handheldBtn setImage:MMGetImage(@"fanmian1") forState:(UIControlStateNormal)];
    [handheldBtn addTarget:self action:@selector(handheldBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [twoView addSubview:handheldBtn];
    MMViewBorderRadius(handheldBtn, 5, 0, [UIColor clearColor]);
    handheldBtn.sd_layout
    .leftSpaceToView(twoView, WidthRatio(68))
    .rightSpaceToView(twoView,  WidthRatio(68))
    .topSpaceToView(title, HeightRatio(21))
    .heightIs(HeightRatio(287));
    
    signatureImageView = [UIImageView new];
    signatureImageView.userInteractionEnabled = NO;
    signatureImageView.contentMode = UIViewContentModeScaleToFill;
    [handheldBtn addSubview:signatureImageView];
    signatureImageView.sd_layout
	.leftSpaceToView(handheldBtn, WidthRatio(130))
    .rightSpaceToView(handheldBtn, WidthRatio(143))
    .topSpaceToView(handheldBtn, HeightRatio(42))
    .heightIs(HeightRatio(148));
    
    
    UILabel *reverseeLabel = [UILabel new];
    reverseeLabel.text = @"请拍摄手持照片";
    reverseeLabel.backgroundColor = [UIColor clearColor];
    reverseeLabel.textAlignment = NSTextAlignmentCenter;
    reverseeLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    reverseeLabel.textColor = [UIColor whiteColor];
    [handheldBtn addSubview:reverseeLabel];
    reverseeLabel.sd_layout
    .centerXEqualToView(handheldBtn)
    .bottomSpaceToView(handheldBtn, HeightRatio(32))
    .heightIs(HeightRatio(28))
    .widthIs(WidthRatio(335));
}
-(void)setRulesView{
    rulesView = [UIView new];
    rulesView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:rulesView];
    rulesView.sd_layout
    .leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topSpaceToView(twoView, HeightRatio(20))
    .heightIs(HeightRatio(390));
    
    UIButton *title = [UIButton new];
    title.userInteractionEnabled = NO;
    title.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [title setImage:MMGetImage(@"*") forState:(UIControlStateNormal)];
    [title setTitle:@"拍摄身份证要求" forState:(UIControlStateNormal)];
    [title setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [title setImagePositionWithType:(ImagePositionTypeLeft) spacing:WidthRatio(28) leftSpacing:0];
    [rulesView addSubview:title];
    title.sd_layout
    .leftSpaceToView(rulesView, WidthRatio(30))
    .topSpaceToView(rulesView, HeightRatio(19))
    .heightIs(HeightRatio(27))
    .widthIs(WidthRatio(230));
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 2;
    titleLabel.text = @"			公民持有的本人有效二代身份证；拍摄时确保身份证边框完整，字体清晰，亮度均予";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    [rulesView addSubview:titleLabel];
    titleLabel.sd_layout
    .leftSpaceToView(rulesView, WidthRatio(81))
    .topSpaceToView(title, HeightRatio(40))
    .rightSpaceToView(rulesView, WidthRatio(81))
    .heightIs(HeightRatio(65));
    
    UIImageView *oneImageView = [UIImageView new];
    oneImageView.image = MMGetImage(@"biaozhun");
    [rulesView addSubview:oneImageView];
    oneImageView.sd_layout
    .leftSpaceToView(rulesView, WidthRatio(21))
    .topSpaceToView(titleLabel, HeightRatio(28))
    .widthIs(WidthRatio(159))
    .heightIs(HeightRatio(140));
    
    UILabel *oneLabel = [UILabel new];
    oneLabel.text = @"标准";
    oneLabel.textColor = HEX_COLOR(0x0a8af2);
    oneLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [rulesView addSubview:oneLabel];
    oneLabel.sd_layout
    .centerXEqualToView(oneImageView)
    .topSpaceToView(oneImageView, HeightRatio(30))
    .widthIs(WidthRatio(55))
    .heightIs(HeightRatio(26));
    
    
    UIImageView *twoImageView = [UIImageView new];
    twoImageView.image = MMGetImage(@"queshi");
    [rulesView addSubview:twoImageView];
    twoImageView.sd_layout
    .leftSpaceToView(oneImageView, WidthRatio(21))
    .topSpaceToView(titleLabel, HeightRatio(28))
    .widthIs(WidthRatio(159))
    .heightIs(HeightRatio(140));
    
    UILabel *twoLabel = [UILabel new];
    twoLabel.text = @"边框缺失";
    twoLabel.textColor = HEX_COLOR(0x0a8af2);
    twoLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [rulesView addSubview:twoLabel];
    twoLabel.sd_layout
    .centerXEqualToView(twoImageView)
    .topSpaceToView(twoImageView, HeightRatio(30))
    .widthIs(WidthRatio(110))
    .heightIs(HeightRatio(26));
    
    UIImageView *threeImageView = [UIImageView new];
    threeImageView.image = MMGetImage(@"mohu");
    [rulesView addSubview:threeImageView];
    threeImageView.sd_layout
    .leftSpaceToView(twoImageView, WidthRatio(21))
    .topSpaceToView(titleLabel, HeightRatio(28))
    .widthIs(WidthRatio(159))
    .heightIs(HeightRatio(140));
    
    UILabel *threeLabel = [UILabel new];
    threeLabel.text = @"表面模糊";
    threeLabel.textColor = HEX_COLOR(0x0a8af2);
    threeLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [rulesView addSubview:threeLabel];
    threeLabel.sd_layout
    .centerXEqualToView(threeImageView)
    .topSpaceToView(threeImageView, HeightRatio(30))
    .widthIs(WidthRatio(110))
    .heightIs(HeightRatio(26));
    
    UIImageView *fourImageView = [UIImageView new];
    fourImageView.image = MMGetImage(@"qianglie");
    [rulesView addSubview:fourImageView];
    fourImageView.sd_layout
    .leftSpaceToView(threeImageView, WidthRatio(31))
    .topSpaceToView(titleLabel, HeightRatio(28))
    .widthIs(WidthRatio(159))
    .heightIs(HeightRatio(140));
    
    UILabel *fourLabel = [UILabel new];
    fourLabel.text = @"闪光缺失";
    fourLabel.textColor = HEX_COLOR(0x0a8af2);
    fourLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [rulesView addSubview:fourLabel];
    fourLabel.sd_layout
    .centerXEqualToView(fourImageView)
    .topSpaceToView(fourImageView, HeightRatio(30))
    .widthIs(WidthRatio(110))
    .heightIs(HeightRatio(26));
    
    
//    UIImageView *highlightedImage = [UIImageView new];
//    highlightedImage.image = MMGetImage(@"guang");
//    [rulesView addSubview:highlightedImage];
//    highlightedImage.sd_layout
//    .centerXEqualToView(fourImageView)
//    .centerYEqualToView(fourImageView)
//    .widthIs(WidthRatio(50))
//    .heightIs(HeightRatio(50));
    
    
    
    
}

-(void)setInformationView{
    
    informationView = [UIView new];
    informationView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:informationView];
    informationView.sd_layout
    .leftEqualToView(self.scrollView)
    .rightEqualToView(self.scrollView)
    .topSpaceToView(rulesView, HeightRatio(20))
    .heightIs(HeightRatio(287));
    
    UIButton *title = [UIButton new];
    title.userInteractionEnabled = NO;
    title.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [title setImage:MMGetImage(@"*") forState:(UIControlStateNormal)];
    [title setTitle:@"个人信息" forState:(UIControlStateNormal)];
    [title setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [title setImagePositionWithType:(ImagePositionTypeLeft) spacing:WidthRatio(28) leftSpacing:0];
    [informationView addSubview:title];
    title.sd_layout
    .leftSpaceToView(informationView, WidthRatio(30))
    .topSpaceToView(informationView, HeightRatio(19))
    .heightIs(HeightRatio(27))
    .widthIs(WidthRatio(170));
    
    [informationView addSubview:self.nameTextField];
    self.nameTextField.sd_layout
    .leftSpaceToView(informationView, WidthRatio(30))
    .rightSpaceToView(informationView,  WidthRatio(30))
    .topSpaceToView(title, HeightRatio(16))
    .heightIs(HeightRatio(86));
    
    [informationView addSubview:self.idCardTextField];
    self.idCardTextField.sd_layout
    .leftSpaceToView(informationView, WidthRatio(30))
    .rightSpaceToView(informationView,  WidthRatio(30))
    .topSpaceToView(self.nameTextField, HeightRatio(36))
    .heightIs(HeightRatio(86));
}

-(void)setNavigationBar{
    self.navigationBarView = [UIView new];
    self.navigationBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, NavBarHeight);
    [self.view addSubview:self.navigationBarView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)HEX_COLOR(0x2f72b6).CGColor, (__bridge id)HEX_COLOR(0x2f72b6).CGColor,(__bridge id)HEX_COLOR(0x27c2ed).CGColor];
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.navigationBarView.frame;
    [self.navigationBarView.layer addSublayer:gradientLayer];

    
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[[self imageWithOriImageName:@"back"] redrawImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backBtn addTarget:self action:@selector(axcBaseClickBaseLeftImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:backBtn];
    backBtn.sd_layout
    .leftSpaceToView(self.navigationBarView, WidthRatio(21))
    .bottomSpaceToView(self.navigationBarView, HeightRatio(0))
    .widthIs(WidthRatio(60))
    .heightIs(HeightRatio(80));
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"身份认证";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(35)];
    [self.navigationBarView addSubview:titleLabel];
    titleLabel.sd_layout
    .centerXEqualToView(self.navigationBarView)
    .bottomSpaceToView(self.navigationBarView, HeightRatio(30))
    .widthIs(300)
    .heightIs(HeightRatio(35));
}
-(void)axcBaseClickBaseLeftImageBtn:(UIButton *)send{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)positiveBtnClick{
    NSLog(@"正面照");
    WS(weakSelf);
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    [AVCaptureVC setPhotographCompleteCallBack:^(IDInfo *info) {
        if (![NSString isNOTNull:info.name]&&![NSString isNOTNull:info.num]) {
                //姓名
            weakSelf.nameTextField.text = info.name;
                //身份证号
            weakSelf.idCardTextField.text = info.num;
                //身份证图片
            self->idCardPositiveImage = info.IDImage;
            self->idCardPositiveImageView.image = info.IDImage;
                //地址
            self->address = info.address;
//            [self->positiveBtn setImage:info.IDImage forState:(UIControlStateNormal)];
            [self setButtonBackgroundColor];
        }else{
            
        }
        
    }];
    
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}
-(void)reverseeBtnClick{
    NSLog(@"反面照");
    JQAVCaptureViewController *AVCaptureVC = [[JQAVCaptureViewController alloc] init];
    [AVCaptureVC setPhotographCompleteCallBack:^(IDInfo *info) {
        NSLog(@"签发机关 = %@  有效期 = %@",info.issue,info.valid);
        if (![NSString isNOTNull:info.issue]&&![NSString isNOTNull:info.valid]) {
            self->idCardBackImage = info.IDImage;
            self->idCardBackImageView.image = info.IDImage;
//            [self->reverseeBtn setImage:info.IDImage forState:(UIControlStateNormal)];
            [self setButtonBackgroundColor];
        }else{
            
        }
    }];
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}
-(void)handheldBtnClick{
    NSLog(@"手持照");
    self.manager.configuration.saveSystemAblum = YES;
    [self hx_presentAlbumListViewControllerWithManager:self.manager delegate:self];
}

-(UITextField *)nameTextField{
    if (!_nameTextField) {
        UITextField *tf = [[UITextField alloc] init];
        
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
            //        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.placeholder = @"请输入姓名";
        [tf setValue:HEX_COLOR(0xBCBCBC) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x555858);
        tf.font = [UIFont systemFontOfSize:HeightRatio(31)];
        tf.backgroundColor = [UIColor clearColor];
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(205), HeightRatio(86))];
        lv.backgroundColor = [UIColor clearColor];
        
        UILabel *titileLabel = [UILabel new];
        titileLabel.text = @"姓名";
        titileLabel.textAlignment = NSTextAlignmentLeft;
        titileLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
        titileLabel.textColor = HEX_COLOR(0xb9b9b9);
        [lv addSubview:titileLabel];
        [titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(11));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(1);
            make.height.mas_equalTo(HeightRatio(28));
        }];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        [tf sizeToFit];
        tf.userInteractionEnabled = NO;
        
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xdcecf4);
        [tf addSubview:lin];
        [lin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(1));
        }];
        
        _nameTextField = tf;
    }
    return _nameTextField;
}
-(UITextField *)idCardTextField{
    if (!_idCardTextField) {
        UITextField *tf = [[UITextField alloc] init];
        
            //        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.placeholder = @"请输入真实身份证号码" ;
        [tf setValue:HEX_COLOR(0xBCBCBC) forKeyPath:@"_placeholderLabel.textColor"];
        tf.textColor = HEX_COLOR(0x555858);
        tf.font = [UIFont systemFontOfSize:HeightRatio(31)];
        tf.backgroundColor = [UIColor clearColor];
        
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(205), HeightRatio(86))];
        lv.backgroundColor = [UIColor clearColor];
        
        UILabel *titileLabel = [UILabel new];
        titileLabel.text = @"身份证号";
        titileLabel.textAlignment = NSTextAlignmentLeft;
        titileLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
        titileLabel.textColor = HEX_COLOR(0xb9b9b9);
        [lv addSubview:titileLabel];
        [titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lv.mas_left).offset(WidthRatio(11));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(1);
            make.height.mas_equalTo(HeightRatio(28));
        }];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = lv;
        tf.userInteractionEnabled = NO;
        [tf sizeToFit];
        UILabel *lin = [UILabel new];
        lin.backgroundColor = HEX_COLOR(0xdcecf4);
        [tf addSubview:lin];
        [lin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(tf);
            make.height.mas_equalTo(HeightRatio(1));
        }];
        _idCardTextField = tf;
        
    }
    return _idCardTextField;
}
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.singleSelected = YES;
        _manager.configuration.albumListTableView = ^(UITableView *tableView) {
            
        };
    }
    return _manager;
}

- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}
#pragma mark === 签名照选择
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if (photoList.count > 0) {
        HXPhotoModel *model = photoList.firstObject;
        signatureImage = model.previewPhoto;
        self->signatureImageView.image = model.previewPhoto;
        [self setButtonBackgroundColor];
        NSSLog(@"%lu张图片",(unsigned long)photoList.count);
    }else if (videoList.count > 0) {
        [self.toolManager getSelectedImageList:allList success:^(NSArray<UIImage *> *imageList) {
            self->signatureImage = imageList.firstObject;
            self->signatureImageView.image = imageList.firstObject;
            [self setButtonBackgroundColor];
        } failed:^{
            
        }];
        
    }
}
-(void)completeClick{
    if (signatureImage == nil) {
        [WXZTipView showCenterWithText:@"请上传签名照"];
        return;
    }
    if (idCardPositiveImage == nil) {
        [WXZTipView showCenterWithText:@"请上传身份证正面照"];
        return;
    }
    if (idCardBackImage == nil) {
        [WXZTipView showCenterWithText:@"请上传身份证反面照"];
        return;
    }
    if ([NSString isNOTNull:self.token]) {
        [WXZTipView showCenterWithText:@"缺少用户信息"];
        return;
    }
    NSDictionary *dict = @{@"address": address,
                           @"realname":self.nameTextField.text,
                           @"idcard":self.idCardTextField.text,
                           @"token":self.token
                           };
    NSDictionary *imageDict = @{@"img[0]":idCardPositiveImage,
                                @"img[1]":idCardBackImage,
                                @"img[2]":signatureImage
                                };
    
    [NetWorkHelper setRequestTimeoutInterval:20.0];
    [NetWorkHelper openNetworkActivityIndicator:YES];
    [self showRoundProgressWithTitle: @"加载中"];
    
    
    [NetWorkHelper uploadImagesWithURL:MMNSStringFormat(@"%@my/auth",@"http://eat.zhongchangjy.com/") parameters:dict names:nil images:nil imagesDict:imageDict fileNames:nil imageScale:0.5 imageType:@"jpg" progress:^(NSProgress *progress) {
        
    } success:^(BOOL isOk, id responseObject) {
        [self hideBubble];
        NSLog(@"responseObject = %@",responseObject);
        if (isOk) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSString *status = MMNSStringFormat(@"%@",data[@"status"]);
            if ([status integerValue] == -1) {
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }else if([status integerValue] == 1){
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }
            
            
        }else{
            [WXZTipView showCenterWithText:responseObject duration:3];
        }
    }];
    
}
-(void)setButtonBackgroundColor{
    if (signatureImage!=nil&&idCardPositiveImage != nil&&idCardBackImage!=nil) {
        button.userInteractionEnabled = YES;
        [button setBackgroundColor:HEX_COLOR(0x27c2ed)];
    }else{
        button.userInteractionEnabled = NO;
         [button setBackgroundColor:HEX_COLOR(0xbdc4cf)];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
