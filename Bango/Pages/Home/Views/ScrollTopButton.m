//
//  ScrollTopButton.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ScrollTopButton.h"

@implementation ScrollTopButton
{
    __weak UIScrollView *_scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scrollView{
    
    if (self = [super initWithFrame:frame]) {
        [self setupWithScrollView:scrollView];
    }
    return self;
}

- (void)setupWithScrollView:(UIScrollView *)scrollView{
//    CGFloat DefaultW = WidthRatio(40);
    _scrollView = scrollView;
//    self.distanceWhenShow = self.distanceWhenShow ?:SCREEN_HEIGHT;
    self.distanceWhenShow = 100;

    
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[UIImage imageNamed:@"home_toTopButton"] forState:UIControlStateNormal];
//    self.frame = CGRectMake(CGRectGetMaxX(scrollView.frame) - DefaultW - WidthRatio(15), CGRectGetHeight(scrollView.frame) - WidthRatio(100), DefaultW, DefaultW);

//    self.frame = CGRectMake(SCREEN_WIDTH - DefaultW - WidthRatio(15), SCREEN_HEIGHT - WidthRatio(100), DefaultW, DefaultW);
    [self addTarget:self action:@selector(scrollToTopClick) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)scrollToTopClick{
    
    [_scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGPoint point = [change[@"new"] CGPointValue];
    if (point.y <= self.distanceWhenShow) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}

- (void)dealloc{
    
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
