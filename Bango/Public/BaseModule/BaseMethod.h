//
//  BaseMethod.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseMethod : NSObject
#pragma mark - UIColor 转UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color;


#pragma mark - NSUserDefaules操作
+ (void)saveObject:(NSObject *)object withKey:(NSString *)key;
+ (id)readObjectWithKey:(NSString *)key;
+ (void)cleanObjectForKey:(NSString *)key;

#pragma mark - PhotoLibrary

/**
 保存相片到相机胶卷

 @param image 要保存的图片
 */
+ (void)writeImageToPhotoLibrary:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
