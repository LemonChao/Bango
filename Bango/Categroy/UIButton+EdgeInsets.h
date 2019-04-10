//
//  UIButton+EdgeInsets.h
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZCImagePosition) {
    ZCImagePositionLeft,   //图片在左，标题在右，默认风格
    ZCImagePositionRight,  //图片在右，标题在左
    ZCImagePositionTop,    //图片在上，标题在下
    ZCImagePositionBottom  //图片在下，标题在上
};


NS_ASSUME_NONNULL_BEGIN

/**
 默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 
 if (button.width小于imageView上image的width){图像会被压缩，文字不显示}
 
 if (button.width < imageView.width + label.width){图像正常显示，文字显示不全,这种情况下竖直排列时,要特别注意,已解决}
 https://www.jianshu.com/p/f521505beed9
 if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙}
 */
@interface UIButton (EdgeInsets)


/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(ZCImagePosition)postion spacing:(CGFloat)spacing;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param margin 图片、文字离button边框的距离
 */
- (void)setImagePosition:(ZCImagePosition)postion WithMargin:(CGFloat )margin;

@end

NS_ASSUME_NONNULL_END
