//
//  UITableView+Refresh.h
//  AFNTest
//
//  Created by 张海彬 on 2017/3/20.
//  Copyright © 2017年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "CustomRefreshGifHeader.h"
/**
 添加下拉刷新和上拉加载
 */
@interface UITableView (Refresh)

/**
 下拉刷新数据操作

 @param handler 回调
 */
- (void)refreshingData:(void(^)(void))handler;

/**
 上拉加载更多数据

 @param handler 回调
 */
- (void)loadMoreDada:(void (^)(void))handler;

/**
 开始刷新
 */
- (void)beginRefreshing;

/**
 结束刷新
 */
- (void)endRefreshing;

/**
 结束加载更多
 */
- (void)endLoadMore;

/**
 没有更多数据，即加载完毕
 */
- (void)endLoadWithNoMoreData;

/**
 隐藏加载更多

 @param hidden 是否隐藏 
 */
- (void)setLoadMoreViewHidden:(BOOL)hidden;

/**
 显示无数据标志

 @param image 图片，为nil时只显示文字
 @param text 文字
 */
- (void)showNoDataWithImage:(UIImage *)image text:(NSString *)text;

/**
 *  隐藏无数据标志
 */
- (void)hideNoData;

@end
