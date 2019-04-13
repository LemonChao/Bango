//
//  ZCCartManager.m
//  Bango
//
//  Created by zchao on 2019/4/13.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCartManager.h"

@implementation ZCCartManager

+ (instancetype)manager {
    static ZCCartManager *_manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ZCCartManager alloc] init];
        _manager.goodsDic = [NSMutableDictionary dictionary];
    });
    
    return _manager;
}





@end
