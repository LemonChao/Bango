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
    [self configCustomNav];
    [self configViews];
    [self bindViewModel];
}

- (void)configCustomNav {}
- (void)configViews {}
- (void)bindViewModel {}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.view bringSubviewToFront:self.customNavBar];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setupNavBar {
    [self.view addSubview:self.customNavBar];
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
        _customNavBar.titleLabelColor = [UIColor blackColor];
        _customNavBar.backgroundColor = [UIColor whiteColor];
        if (self.navigationController.childViewControllers.count != 1) {
            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_white"]];
        }

    }
    return _customNavBar;
}

@end
