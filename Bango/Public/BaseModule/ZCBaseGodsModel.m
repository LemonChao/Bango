//
//  ZCBaseGodsModel.m
//  Bango
//
//  Created by zchao on 2019/4/11.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseGodsModel.h"

@implementation ZCBaseGodsModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.have_num = @"0";
        self.hide = YES;
        self.deleteEnsure = NO;
    }
    return self;
}
@end
