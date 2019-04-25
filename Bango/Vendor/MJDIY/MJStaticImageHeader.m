//
//  MJStaticImageHeader.m
//  Bango
//
//  Created by zchao on 2019/4/23.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "MJStaticImageHeader.h"

@interface MJStaticImageHeader ()

@property(nonatomic, strong) UIImageView *headerImg;

@end

@implementation MJStaticImageHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = WidthRatio(150);
    self.backgroundColor = HEX_COLOR(0xf5f5f5);
    
    // 添加label
    self.headerImg = [UITool imageViewImage:ImageNamed(@"MJStaticImageHeader") contentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.headerImg];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.headerImg.center = CGPointMake(self.mj_w/2, self.mj_h/2);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
//    switch (state) {
//        case MJRefreshStateIdle:
//            [self.loading stopAnimating];
//            [self.s setOn:NO animated:YES];
//            self.label.text = @"赶紧下拉吖(开关是打酱油滴)";
//            break;
//        case MJRefreshStatePulling:
//            [self.loading stopAnimating];
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
//            break;
//        case MJRefreshStateRefreshing:
//            [self.s setOn:YES animated:YES];
//            self.label.text = @"加载数据中(开关是打酱油滴)";
//            [self.loading startAnimating];
//            break;
//        default:
//            break;
//    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
//    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
