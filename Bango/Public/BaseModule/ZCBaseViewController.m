//
//  ZCBaseViewController.m
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewController.h"

@interface ZCBaseViewController ()

@end

@implementation ZCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self configCustomNav];
    [self configViews];
    [self bindViewModel];
}

- (void)configCustomNav {}
- (void)configViews {}
- (void)bindViewModel {}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view bringSubviewToFront:self.customNavBar];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setupNavBar {
    [self.view addSubview:self.customNavBar];
}

//控制StatusBar是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
//控制StatusBar显示模式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//控制StatusBar动画方式
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

#pragma mark - initView
- (void)setBgViewCorlor
{
    self.navigationController.navigationBar.hidden = YES;
//    [self.view addSubview:self.customNaview];
}

- (void)updateStatus
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
//    [self.view bringSubviewToFront:self.customNaview];
}

#pragma mark - setter && getter
- (WRCustomNavigationBar *)customNavBar
{
    if (!_customNavBar) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
//        _customNavBar.titleLabelColor = [UIColor blackColor];
//        _customNavBar.backgroundColor = [UIColor whiteColor];
        [_customNavBar wr_setBottomLineHidden:NO];
        if (self.navigationController.childViewControllers.count != 1) {
            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_black"]];
        }

    }
    return _customNavBar;
}

@end
