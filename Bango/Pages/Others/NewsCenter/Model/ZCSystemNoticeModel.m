//
//  ZCSystemNoticeModel.m
//  Bango
//
//  Created by zchao on 2019/4/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCSystemNoticeModel.h"

@implementation ZCSystemNoticeModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"aid":@"id"};
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    if (!StringIsEmpty(_create_time)) {
        _showTime = [_create_time stringFromeTimestampWithDataFormat:@"yyyy/MM/dd"];
    }

    return YES;
}

@end
