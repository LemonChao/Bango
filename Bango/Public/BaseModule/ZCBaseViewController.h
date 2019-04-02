//
//  ZCBaseViewController.h
//  Bango
//
//  Created by zchao on 2019/3/7.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRCustomNavigationBar.h"
#import "MJRefresh.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseViewController : UIViewController
- (void)configCustomNav;
- (void)configViews;
- (void)bindViewModel;
- (void)setupNavBar;

/**
 自定义导航栏
 */
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;


@end

NS_ASSUME_NONNULL_END
