//
//  BaseMethod.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "BaseMethod.h"
#import <Photos/Photos.h>

@implementation BaseMethod

#pragma mark - UIColor 转UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - NSUserDefaules操作


+ (void)saveObject:(NSObject *)object withKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}

+ (id)readObjectWithKey:(NSString *)key {
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        //消除警告 -[NSKeyedUnarchiver initForReadingWithData:]: data is NULL
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }else {
        return nil;
    }
}

+ (void)deleteObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


#pragma mark - PhotoLibrary

+ (void)writeImageToPhotoLibrary:(UIImage *)image {
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status !=PHAuthorizationStatusAuthorized) return; //
        
        // 保存相片到相机胶卷
        __block PHObjectPlaceholder *createdAsset = nil;
        //异步执行
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            
            createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [WXZTipView showBottomWithText:@"保存成功"];
                });
            }else {
                NSLog(@"Error: %@", [error localizedDescription]);
            }
            
        }];
    }];
}


@end
