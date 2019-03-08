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
    [self configCustomNav];
    [self configViews];
    [self bindViewModel];
}

- (void)configCustomNav {}
- (void)configViews {}
- (void)bindViewModel {}


@end
