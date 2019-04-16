//
//  ZCBaseView.m
//  Bango
//
//  Created by zchao on 2019/3/19.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseView.h"

@implementation ZCBaseView

- (ZCBaseViewController *)viewController {
    UIView *next = self;
    while ((next = [next superview])) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[ZCBaseViewController class]]) {
            return (ZCBaseViewController *)nextResponder;
        }
    }
    return nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
