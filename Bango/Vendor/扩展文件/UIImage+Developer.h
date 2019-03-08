//
//  UIImage+Developer.h
//  SDFastSendUser
//
//  Created by 张海彬 on 2017/8/26.
//  Copyright © 2017年 SDJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Developer)
/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;
@end
