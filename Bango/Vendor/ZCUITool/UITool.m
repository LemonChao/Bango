//
//  UITool.m
//  HanPay
//
//  Created by zchao on 2019/3/2.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "UITool.h"
#import "UITextView+ZWPlaceHolder.h"

@implementation UITool
/// UIView
+ (UIView *)viewCornerRadius:(CGFloat)cornerRadius {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    return view;
}
+ (UIView *)viewCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = [borderColor CGColor];
    
    return view;
}

+ (UIView *)viewWithColor:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

#pragma mark - Label
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [self labelWithText:nil textColor:textColor font:font backgroundColor:[UIColor clearColor]];
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font alignment:(NSTextAlignment)alignment {
    UILabel *label = [self labelWithText:nil textColor:textColor font:font alignment:alignment numberofLines:1 backgroundColor:[UIColor clearColor]];
    return label;
}
+ (UILabel *)labelWithText:(nullable NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [self labelWithText:text textColor:textColor font:font backgroundColor:[UIColor clearColor]];
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
           backgroundColor:(UIColor *)backgroundColor{
    UILabel *label = [self labelWithText:text textColor:textColor font:font alignment:NSTextAlignmentLeft numberofLines:1 backgroundColor:backgroundColor];
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
                 alignment:(NSTextAlignment)alignment
             numberofLines:(NSInteger)lines
           backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = alignment;
    label.numberOfLines = lines;
    label.backgroundColor = backgroundColor;
    return label;
}

#pragma mark - button
+ (UIButton *)wordButton:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor {
    UIButton *button = [self wordButton:UIButtonTypeCustom title:title titleColor:titleColor font:font bgColor:backgroundColor];
    return button;
}

+ (UIButton *)wordButton:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor {
    UIButton *button = [UIButton buttonWithType:type];
    button.titleLabel.font = font;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = backgroundColor;
    return button;
}

+ (UIButton *)imageButton:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}
+ (UIButton *)imageButton:(UIImage *)image cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.layer.cornerRadius = cornerRadius;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = [borderColor CGColor];
    return button;
}

+ (UIButton *)richButton:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font bgColor:(UIColor *)backgroundColor image:(UIImage *)image {
    UIButton *button = [self wordButton:type title:title titleColor:titleColor font:font bgColor:backgroundColor];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

/// UITextField
+ (UITextField *)textField:(NSString *)placeHolder textColor:(UIColor *)textColor font:(UIFont *)font borderStyle:(UITextBorderStyle)style {
    
    UITextField *textField = [self textField:placeHolder textColor:textColor font:font borderStyle:style alignment:NSTextAlignmentLeft];

    return textField;
}


+ (UITextField *)textField:(NSString *)placeHolder textColor:(UIColor *)textColor font:(UIFont *)font borderStyle:(UITextBorderStyle)style alignment:(NSTextAlignment)alignment{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeHolder;
    textField.textColor = textColor;
    textField.font = font;
    textField.borderStyle = style;
    textField.textAlignment = alignment;
    return textField;
}

/// UITextView
+ (UITextView *)textViewText:(nullable NSString *)text font:(UIFont *)font textColor:(UIColor *)color placeHolder:(NSString *)placeHolder placeholderColor:(UIColor *)placeHolderColor {
    UITextView *textView = [[UITextView alloc] init];
    textView.text = text;
    textView.textColor = color;
    textView.placeholder = placeHolder;
    textView.zw_placeHolderColor =placeHolderColor;
    
    return textView;
}

/// UIImageView
+ (UIImageView *)imageViewImage:(nullable UIImage *)image contentMode:(UIViewContentMode)mode {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = mode;
    return imageView;
}

//
+ (UIImageView *)imageViewPlaceHolder:(nullable UIImage *)image contentMode:(UIViewContentMode)mode cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = mode;
    imageView.layer.cornerRadius = radius;
    imageView.layer.borderWidth = width;
    imageView.layer.borderColor = [color CGColor];
    
    return imageView;
}

@end
