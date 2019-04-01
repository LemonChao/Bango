//
//  ZCBaseNavigationController.m
//  Bango
//
//  Created by zchao on 2019/3/14.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseNavigationController.h"

@interface ZCBaseNavigationController ()

@end

@implementation ZCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // no: 解决scrollView 网上偏移
    self.navigationBar.translucent = NO;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
