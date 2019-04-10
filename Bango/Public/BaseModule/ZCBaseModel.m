//
//  ZCBaseModel.m
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseModel.h"

@implementation ZCBaseModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.count = @"0";
        self.hide = YES;
    }
    return self;
}

@end
