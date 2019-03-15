//
//  ZCBaseViewModel.h
//  Bango
//
//  Created by zchao on 2019/3/15.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCBaseViewModel : NSObject

@property (nonatomic, assign) NSInteger reload;
/**
 登录指令
 */
@property (nonatomic, strong) RACSubject *loginSubject;
/**
 第几页
 */
@property (nonatomic, assign) NSInteger page;
/**
 总共的页数
 */
@property (nonatomic, assign) NSInteger pageNum;

/**
 附加页面第几页
 */
@property (nonatomic, assign) NSInteger page1;
/**
 附加页面总共的页数
 */
@property (nonatomic, assign) NSInteger pageNum1;

@end

NS_ASSUME_NONNULL_END
