//
//  ZCFallingAnimationView.m
//  Bango
//
//  Created by zchao on 2019/3/21.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCFallingAnimationView.h"

#define ANGLE_TO_RADIAN(angle) ((angle)/180.0 * M_PI)


@interface ZCFallingAnimationView ()

@end


@implementation ZCFallingAnimationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        [UIApplication.sharedApplication.keyWindow addSubview:self];
        
        [self positionAnimation];
        [self carambolaAnimation];
        [self pearAnimation];
        [self lemonAnimation];
        [self mangosteenAnimation];

    }
    return self;
}

- (void)positionAnimation {//banana

    //自定义一个图层
    CALayer *bananaLayer=[[CALayer alloc]init];
    UIImage *bananaImg = ImageNamed(@"login_banana");
    bananaLayer.frame = CGRectMake(0, 0, bananaImg.size.width, bananaImg.size.width);
    bananaLayer.contents = (id)bananaImg.CGImage;
    [self.layer addSublayer:bananaLayer];

    UIBezierPath *bananaPath = [UIBezierPath bezierPath];
    [bananaPath moveToPoint:CGPointMake(WidthRatio(126), WidthRatio(10))];
    //曲线1
    [bananaPath addQuadCurveToPoint:CGPointMake(WidthRatio(214), WidthRatio(118)) controlPoint:CGPointMake(WidthRatio(214), WidthRatio(60))];
    [bananaLayer addAnimation:[self animationGroupWithPath:bananaPath] forKey:@"BananaAnimation_Position"];
}

- (void)carambolaAnimation {
    
    //自定义一个图层
    CALayer *bananaLayer=[[CALayer alloc]init];
    UIImage *bananaImg = ImageNamed(@"login_carambola");
    bananaLayer.frame = CGRectMake(WidthRatio(214), WidthRatio(118), bananaImg.size.width, bananaImg.size.width);
    bananaLayer.contents = (id)bananaImg.CGImage;
    [self.layer addSublayer:bananaLayer];
    
    //曲线2
    UIBezierPath *bananaPath = [UIBezierPath bezierPath];
    [bananaPath moveToPoint:CGPointMake(WidthRatio(214), WidthRatio(118))];
    [bananaPath addCurveToPoint:CGPointMake(WidthRatio(198),WidthRatio(238)) controlPoint1:CGPointMake(WidthRatio(214), WidthRatio(165)) controlPoint2:CGPointMake(WidthRatio(164),WidthRatio(128))];
    [bananaLayer addAnimation:[self animationGroupWithPath:bananaPath] forKey:@"BananaAnimation_Position"];
}

- (void)pearAnimation {
    //自定义一个图层
    CALayer *bananaLayer=[[CALayer alloc]init];
    UIImage *bananaImg = ImageNamed(@"login_pear");
    bananaLayer.frame = CGRectMake(0, 0, bananaImg.size.width, bananaImg.size.width);
    bananaLayer.contents = (id)bananaImg.CGImage;
    [self.layer addSublayer:bananaLayer];
    
    //曲线3
    UIBezierPath *bananaPath = [UIBezierPath bezierPath];
    [bananaPath moveToPoint:CGPointMake(WidthRatio(198), WidthRatio(238))];
    [bananaPath addCurveToPoint:CGPointMake(WidthRatio(140), WidthRatio(390)) controlPoint1:CGPointMake(WidthRatio(230), WidthRatio(297)) controlPoint2:CGPointMake(WidthRatio(108), WidthRatio(332))];
    [bananaLayer addAnimation:[self animationGroupWithPath:bananaPath] forKey:@"BananaAnimation_Position"];
}

- (void)lemonAnimation {
    //自定义一个图层
    CALayer *bananaLayer=[[CALayer alloc]init];
    UIImage *bananaImg = ImageNamed(@"login_lemon");
    bananaLayer.frame = CGRectMake(0, 0, bananaImg.size.width, bananaImg.size.width);
    bananaLayer.contents = (id)bananaImg.CGImage;
    [self.layer addSublayer:bananaLayer];
    
    //曲线4
    UIBezierPath *bananaPath = [UIBezierPath bezierPath];
    [bananaPath moveToPoint:CGPointMake(WidthRatio(140), WidthRatio(390))];
    [bananaPath addCurveToPoint:CGPointMake(WidthRatio(223), WidthRatio(440)) controlPoint1:CGPointMake(WidthRatio(160), WidthRatio(425)) controlPoint2:CGPointMake(WidthRatio(212), WidthRatio(432))];
    [bananaLayer addAnimation:[self animationGroupWithPath:bananaPath] forKey:@"BananaAnimation_Position"];

}

- (void)mangosteenAnimation {
    //自定义一个图层
    CALayer *bananaLayer=[[CALayer alloc]init];
    UIImage *bananaImg = ImageNamed(@"login_mangosteen");
    bananaLayer.frame = CGRectMake(0, 0, bananaImg.size.width, bananaImg.size.width);
    bananaLayer.contents = (id)bananaImg.CGImage;
    [self.layer addSublayer:bananaLayer];
    
    //曲线5
    UIBezierPath *bananaPath = [UIBezierPath bezierPath];
    [bananaPath moveToPoint:CGPointMake(WidthRatio(223), WidthRatio(440))];
    [bananaPath addCurveToPoint:CGPointMake(WidthRatio(277), WidthRatio(545)) controlPoint1:CGPointMake(WidthRatio(247), WidthRatio(450)) controlPoint2:CGPointMake(WidthRatio(277), WidthRatio(475))];
    [bananaLayer addAnimation:[self animationGroupWithPath:bananaPath] forKey:@"BananaAnimation_Position"];

}

- (CAAnimation *)animationGroupWithPath:(UIBezierPath *)path {
    
#if 1
    //关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    keyAnimation.path = path.CGPath;
    keyAnimation.duration = 8.0;
    keyAnimation.repeatCount = MAXFLOAT;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.beginTime = CACurrentMediaTime()+0;//立即开始设置延迟0秒执行
    keyAnimation.autoreverses = NO;//自动反转
    return keyAnimation;
    
#else
    //位移动画动画
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = path.CGPath;
    
    //旋转动画
    CAKeyframeAnimation *rotationAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnim.values =@[@(ANGLE_TO_RADIAN(0)),@(ANGLE_TO_RADIAN(-20)),@(ANGLE_TO_RADIAN(20)),@(ANGLE_TO_RADIAN(0))];
    rotationAnim.keyTimes = @[@(0), @(0.47), @(0.52), @(1.0)];
    rotationAnim.fillMode =kCAFillModeForwards;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[positionAnimation, rotationAnim];
    // 动画时间
    group.duration = 8.0f;
    //无限次重复
    group.repeatCount= MAXFLOAT;
    // 保持最后的状态
    group.removedOnCompletion = NO;
    //自动反转
    group.autoreverses = NO;
    return group;
#endif
}

//- (void)drawRect:(CGRect)rect {
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(WidthRatio(126), WidthRatio(10))];
//    /**
//     二次贝塞尔曲线，曲线段在当前点开始，在指定的点结束
//
//     @param toPoint 结束点
//     @param controlPoint 控制点
//     */
//    //曲线1
//    [path addQuadCurveToPoint:CGPointMake(WidthRatio(214), WidthRatio(118)) controlPoint:CGPointMake(WidthRatio(214), WidthRatio(60))];
//    //曲线2
//    [path addCurveToPoint:CGPointMake(WidthRatio(198), WidthRatio(238)) controlPoint1:CGPointMake(WidthRatio(214), WidthRatio(165)) controlPoint2:CGPointMake(WidthRatio(164),WidthRatio(128))];
//    //曲线3
//    [path addCurveToPoint:CGPointMake(WidthRatio(140), WidthRatio(390)) controlPoint1:CGPointMake(WidthRatio(230), WidthRatio(297)) controlPoint2:CGPointMake(WidthRatio(108), WidthRatio(332))];
//    //曲线4
//    [path addCurveToPoint:CGPointMake(WidthRatio(223), WidthRatio(440)) controlPoint1:CGPointMake(WidthRatio(160), WidthRatio(425)) controlPoint2:CGPointMake(WidthRatio(212), WidthRatio(432))];
//    //曲线5
//    [path addCurveToPoint:CGPointMake(WidthRatio(277), WidthRatio(545)) controlPoint1:CGPointMake(WidthRatio(247), WidthRatio(450)) controlPoint2:CGPointMake(WidthRatio(277), WidthRatio(475))];
//
//    // 4. 设置颜色, 并绘制路径
//    [[UIColor redColor] set];
//    [path stroke];
//}

@end
