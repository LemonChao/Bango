//
//  UIButton+EdgeInsets.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UIButton+EdgeInsets.h"

@implementation UIButton (EdgeInsets)

#pragma mark -- 按钮上图文混排
- (void)setImagePosition:(ZCImagePosition)postion spacing:(CGFloat)spacing {
    CGFloat imgW = self.imageView.image.size.width;
    CGFloat imgH = self.imageView.image.size.height;
    CGSize showLabSize = self.titleLabel.bounds.size;
    CGFloat showLabW = showLabSize.width;
    CGFloat showLabH = showLabSize.height;
    
    CGSize trueSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat trueLabW = trueSize.width;

    //image中心移动的x距离
    CGFloat imageOffsetX = showLabW/2 ;
    //image中心移动的y距离
    CGFloat imageOffsetY = showLabH/2 + spacing/2;
    //label左边缘移动的x距离
    CGFloat labelOffsetX1 = imgW/2 - showLabW/2 + trueLabW/2;
    //label右边缘移动的x距离
    CGFloat labelOffsetX2 = imgW/2 + showLabW/2 - trueLabW/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = imgH/2 + spacing/2;
    
    switch (postion) {
        case ZCImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case ZCImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, showLabW + spacing/2, 0, -(showLabW + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + spacing/2), 0, imgW + spacing/2);
            break;
            
        case ZCImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX1, -labelOffsetY, labelOffsetX2);
            break;
            
        case ZCImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX1, labelOffsetY, labelOffsetX2);
            break;
            
        default:
            break;
    }
    
}

/**根据图文距边框的距离调整图文间距*/
- (void)setImagePosition:(ZCImagePosition)postion WithMargin:(CGFloat )margin{
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat labelWidth = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    CGFloat spacing = self.bounds.size.width - imageWith - labelWidth - 2*margin;
    
    [self setImagePosition:postion spacing:spacing];
}



@end
