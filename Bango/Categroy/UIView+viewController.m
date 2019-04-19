//
//  UIView+viewController.m
//  Bango
//
//  Created by zchao on 2019/4/17.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UIView+viewController.h"

@implementation UIView (viewController)

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

@end
