//
//  UITableView+Refresh.m
//  KaiyunHealth
//
//  Created by MATRIX on 16/1/8.
//  Copyright © 2016年 KAIYUN CARE. All rights reserved.
//

#import "UITableView+Refresh.h"

@implementation UITableView (Refresh)

- (void)refreshingData:(void (^)(void))handler {
    if (handler) {
        
        __unsafe_unretained UITableView *weakSelf = self;
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if (weakSelf.mj_footer) {
                [weakSelf.mj_footer resetNoMoreData];
            }
            
            handler();
        }];
        
        // 设置文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松手立即刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        
        header.stateLabel.font = [UIFont systemFontOfSize:15];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
        
//        header.stateLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
//        header.lastUpdatedTimeLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        
        header.stateLabel.textColor = [UIColor whiteColor];
         header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
        self.mj_header = header;
    }
}

- (void)loadMoreDada:(void (^)(void))handler  {
    if (handler) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:handler];
        
        // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
        footer.triggerAutomaticallyRefreshPercent = 0.5;
        footer.automaticallyHidden = YES;
        
        // 设置文字
        [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"全部加载完毕" forState:MJRefreshStateNoMoreData];
        
        footer.stateLabel.font = [UIFont systemFontOfSize:15];
        footer.stateLabel.textColor = [UIColor whiteColor];
//        footer.stateLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        
        self.mj_footer = footer;
    }
}

- (void)endLoadWithNoMoreData {
    
    [self.mj_footer endRefreshingWithNoMoreData];
    __unsafe_unretained UITableView *weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.mj_footer setHidden:YES];
    });
}

- (void)beginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)endRefreshing {
    [self.mj_header endRefreshing];
}

- (void)endLoadMore {
    [self.mj_footer endRefreshing];
}

- (void)setLoadMoreViewHidden:(BOOL)hidden {
    [self.mj_footer setHidden:hidden];
}

- (void)showNoDataWithImage:(UIImage *)image text:(NSString *)text {
    
    UIView *view = [[UIView alloc] init];
    view.tag = -999;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = image;
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:iv];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:label];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:iv attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[iv]-[label]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iv, label)]];
}

- (void)hideNoData {
    UIView *view = [self viewWithTag:-999];
    
    if (view) {
        view.hidden = YES;
        [view removeFromSuperview];
    }
}

@end
