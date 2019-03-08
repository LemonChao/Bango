//
//  SELUpdateAlert.h
//  SelUpdateAlert
//
//  Created by zhuku on 2018/2/7.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SELUpdateAlert : UIView
/**
 是否强制更新
 */
@property (nonatomic,assign)BOOL isMandatory;
/**
 立即更新
 */
@property (nonatomic,copy) void (^updateNow)(void);
/**
 取消
 */
@property (nonatomic,copy) void (^dismissBlock)(void);
/**
 添加版本更新提示
 
 @param version 版本号
 @param descriptions 版本更新内容（数组）
 
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (id)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions;

/**
 添加版本更新提示
 
 @param version 版本号
 @param description 版本更新内容（字符串）
 
 description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (id)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description;

@end
