//
//  StatusBarView.m
//  TFC
//
//  Created by 张海彬 on 2018/6/14.
//  Copyright © 2018年 张海彬. All rights reserved.
//

#import "StatusBarView.h"

@implementation StatusBarView
+(instancetype)sharedInstance{
    static StatusBarView *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [StatusBarView new];
    });
    return instance;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
