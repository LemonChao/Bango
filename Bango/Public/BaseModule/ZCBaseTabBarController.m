//
//  ZCBaseTabBarController.m
//  Bango
//
//  Created by zchao on 2019/3/29.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseTabBarController.h"
#import "ZCBaseNavigationController.h"
#import "ZCHomeViewController.h"
#import "ZCWebViewController.h"
#import "ZCClassifyViewController.h"
#import "ZCFindViewController.h"
#import "ZCCartEmptyViewController.h"
#import "ZCPersonalViewController.h"


@interface ZCBaseTabBarController ()

@property(nonatomic, strong) ZCBaseNavigationController *homeNav;
@property(nonatomic, strong) ZCBaseNavigationController *classifyNav;
@property(nonatomic, strong) ZCBaseNavigationController *findNav;
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
        ZCHomeViewController *homeVC = [[ZCHomeViewController alloc] init];
        _homeNav = [[ZCBaseNavigationController alloc] initWithRootViewController:homeVC];
        _homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabBar0_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar0_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} forState:UIControlStateNormal];
        [_homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GeneralRedColor} forState:UIControlStateSelected];
//        _homeNav.tabBarItem.titlePositionAdjustment = UIOffsetMake (0,-2);
//        _homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);

    }
    return _homeNav;
}

- (ZCBaseNavigationController *)classifyNav {
    if (!_classifyNav) {
        ZCClassifyViewController *webVC = [[ZCClassifyViewController alloc] init];
        _classifyNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _classifyNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[[UIImage imageNamed:@"tabBar1_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar1_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_classifyNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} forState:UIControlStateNormal];
        [_classifyNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GeneralRedColor} forState:UIControlStateSelected];
//        _classifyNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
//        _classifyNav.tabBarItem.titlePositionAdjustment = UIOffsetMake (0,-2);

    }
    return _classifyNav;

}

- (ZCBaseNavigationController *)findNav {
    if (!_findNav) {
        ZCFindViewController *webVC = [[ZCFindViewController alloc] init];
        _findNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _findNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tabBar2_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar2_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_findNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} forState:UIControlStateNormal];
        [_findNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GeneralRedColor} forState:UIControlStateSelected];
//        _findNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _findNav;
}



- (ZCBaseNavigationController *)cartNav {
    if (!_cartNav) {
        ZCCartEmptyViewController *webVC = [[ZCCartEmptyViewController alloc] init];
        _cartNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _cartNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[[UIImage imageNamed:@"tabBar3_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar3_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_cartNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} forState:UIControlStateNormal];
        [_cartNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GeneralRedColor} forState:UIControlStateSelected];
//        _cartNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _cartNav;

}

- (ZCBaseNavigationController *)personalNav {
    if (!_personalNav) {
        ZCPersonalViewController *webVC = [[ZCPersonalViewController alloc] init];
        _personalNav = [[ZCBaseNavigationController alloc] initWithRootViewController:webVC];
        _personalNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"会员中心" image:[[UIImage imageNamed:@"tabBar4_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabBar4_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_personalNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} forState:UIControlStateNormal];
        [_personalNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GeneralRedColor} forState:UIControlStateSelected];
//        _personalNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0);
    }
    return _personalNav;

}


@end
