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
    _scrollView = scrollView;
    self.distanceWhenShow = SCREEN_WIDTH*2;

    
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[UIImage imageNamed:@"home_toTopButton"] forState:UIControlStateNormal];
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
