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
- (UIImage *)redrawImageWithColor:(UIColor *)color;


/**
 根据颜色生成图片

 @param color color
 @return image
 */
+ (UIImage *)imageWithColor123124:(UIColor *)color;

/**
 根据view生成图片

 @param view view
 @param size imageSize 如果size为zero，则以view.bounds为准
 @return image
 */
+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size;
@end
