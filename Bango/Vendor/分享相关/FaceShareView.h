//
//  FaceShareView.h
//  Bango
//
//  Created by zchao on 2019/3/19.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceShareView : ZCBaseView

@property(nonatomic, copy) NSDictionary *shareInfo;

- (instancetype)initWithInfo:(NSDictionary *)shareInfo;

@end

NS_ASSUME_NONNULL_END
