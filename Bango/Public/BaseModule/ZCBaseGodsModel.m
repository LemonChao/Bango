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
    }
    return self;
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *have_num = dic[@"have_num"];
    
//    NSLog(@"____hide:%@", dic);
    
    _hide = ![have_num boolValue];
    return YES;
}

@end
