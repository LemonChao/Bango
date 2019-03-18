//
//  UITool.h
//  HanPay
//
//  Created by zchao on 2019/3/2.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//快速创建UI控件
@interface UITool : NSObject

/// UIView
+ (UIView *)viewCornerRadius:(CGFloat)cornerRadius;
+ (UIView *)viewCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIView *)viewWithColor:(UIColor *)color;


/// UILabel
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment;

+ (UILabel *)labelWithText:(nullable NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)labelWithText:(nullable NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment numberofLines:(NSInteger)lines backgroundColor:(UIColor *)backgroundColor;


/// UIButton
+ (UIButton *)wordButton:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor;
+ (UIButton *)wordButton:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor;
+ (UIButton *)imageButton:(UIImage *)image;
+ (UIButton *)imageButton:(UIImage *)image cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
+ (UIButton *)richButton:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor image:(UIImage *)image;

/// UITextField
+ (UITextField *)textField:(NSString *)placeHolder textColor:(UIColor *)textColor font:(UIFont *)font borderStyle:(UITextBorderStyle)style;
+ (UITextField *)textField:(NSString *)placeHolder textColor:(UIColor *)textColor font:(UIFont *)font borderStyle:(UITextBorderStyle)style alignment:(NSTextAlignment)alignment;


/// UITextView
+ (UITextView *)textViewText:(nullable NSString *)text font:(UIFont *)font textColor:(UIColor *)color placeHolder:(NSString *)placeHolder placeholderColor:(UIColor *)placeHolderColor;
/// UIImageView
+ (UIImageView *)imageViewImage:(nullable UIImage*)image contentMode:(UIViewContentMode)mode;
+ (UIImageView *)imageViewImage:(NSString *)imageUrl placeHolder:(nullable UIImage *)image contentMode:(UIViewContentMode)mode;
+ (UIImageView *)imageViewImage:(nullable UIImage *)image contentMode:(UIViewContentMode)mode cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;
+ (UIImageView *)imageViewImage:(NSString *)imageUrl placeHolder:(nullable UIImage *)image contentMode:(UIViewContentMode)mode cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
