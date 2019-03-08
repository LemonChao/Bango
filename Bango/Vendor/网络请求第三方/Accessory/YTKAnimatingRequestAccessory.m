//
//  YTKAnimatingRequestAccessory.m
//  Ape_uni
//
//  Created by Chenyu Lan on 10/30/14.
//  Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "YTKAnimatingRequestAccessory.h"
//#import "YTKAlertUtils.h"
#import "WB_Request.h"

@implementation YTKAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    WB_Request *wb_req = (WB_Request *)request;
//    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: show loading
//             [YTKAlertUtils showLoadingAlertView:_animatingText inView:_animatingView];
            if (!wb_req.isHiddenLoading) {
                [self showRoundProgressWithTitle:self.animatingText];
            }
            NSLog(@" loading start");
            NSLog(@"开始进行请求");
        });
//    }
}

- (void)requestWillStop:(id)request {
//    if (_animatingView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: hide loading
            //[YTKAlertUtils hideLoadingAlertView:_animatingView];
            [self hideBubble];
            NSLog(@" loading finished");
            NSLog(@"请求结束");
        });
//    }
}
-(void)requestDidStop:(id)request{
     
}
@end
