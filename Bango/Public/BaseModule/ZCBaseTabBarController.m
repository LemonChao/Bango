//
//  ZCBaseTabBarController.m
//  Bango
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseTabBarController.h"
#import "ZCBaseNavigationController.h"
#import "ZCWebViewController.h"
#import "ZCClassifyViewController.h"
#import "ZCCartViewController.h"
#import "ZCPersonalViewController.h"


@interface ZCBaseTabBarController ()

@property(nonatomic, strong) ZCBaseNavigationController *homeNav;
@property(nonatomic, strong) ZCBaseNavigationController *classifyNav;
@property(nonatomic, strong) ZCBaseNavigationController *cartNav;
@property(nonatomic, strong) ZCBaseNavigationController *personalNav;

@end

@implementation ZCBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[self.homeNav,self.classifyNav,self.cartNav,self.personalNav];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    self.tabBar.shadowImage = ImageNamed(@"tab");
    
}

- (ZCBaseNavigationController *)homeNav {
    if (!_homeNav) {
        ZCWebViewController *webVC = [[ZCWebViewController alloc] init];
        _homeNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _homeNav;
}

- (ZCBaseNavigationController *)classifyNav {
    if (!_classifyNav) {
        ZCClassifyViewController *webVC = [[ZCClassifyViewController alloc] init];
        _classifyNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _classifyNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _classifyNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _classifyNav;

}


- (ZCBaseNavigationController *)cartNav {
    if (!_cartNav) {
        ZCCartViewController *webVC = [[ZCCartViewController alloc] init];
        _cartNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _cartNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _cartNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _cartNav;

}

- (ZCBaseNavigationController *)personalNav {
    if (!_personalNav) {
        ZCPersonalViewController *webVC = [[ZCPersonalViewController alloc] init];
        _personalNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _personalNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会员中心" image:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Tab0_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _personalNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _personalNav;

}


@end
