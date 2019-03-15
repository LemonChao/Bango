//
//  CornerShadowView.m
//  RegistrationHall
//
//  Created by zchao on 2018/6/8.
//  Copyright © 2018年 Toushi. All rights reserved.
//

#import "CornerShadowView.h"

@implementation CornerShadowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupParameters];
    }
    return self;
}

- (void)setupParameters {
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
    self.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
    self.shadowOffset = CGSizeMake(0, 0);
    self.blur = 5.f;
    self.fillColor = [UIColor whiteColor];
    self.boardInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    self.cornerRadius = 2;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect drawRect = CGRectMake(rect.origin.x + _boardInsets.left, rect.origin.y + _boardInsets.top, rect.size.width - _boardInsets.left- _boardInsets.right, rect.size.height - _boardInsets.top - _boardInsets.bottom);
    
    //路径轮廓的颜色
    CGContextSetFillColorWithColor(context, _fillColor.CGColor);;
    
    CGFloat radius = _cornerRadius; //圆角半径
    
    //画圆角图形
    CGFloat x = drawRect.origin.x;
    CGFloat y = drawRect.origin.y;
    CGFloat width = drawRect.size.width;
    CGFloat height = drawRect.size.height;//画布宽高
    
    CGContextMoveToPoint(context, width, height-radius);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width, height, width-radius, height, radius);  // 右下角角度
    CGContextAddArcToPoint(context, x, height, x, height-radius, radius); // 左下角角度
    CGContextAddArcToPoint(context, x, y, x + radius, y, radius); // 左上角
    CGContextAddArcToPoint(context, width, y, width, y + radius, radius); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径

    //画阴影
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:drawRect cornerRadius:_cornerRadius];
    CGContextSetShadowWithColor(context, _shadowOffset, _blur, _shadowColor.CGColor);
    [shadowPath fill];

    
}

@end
