//
//  ScrollTopButton.h
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollTopButton : UIButton

/**出现的距离*/
@property(nonatomic, assign)CGFloat distanceWhenShow;

/**初始化*/
- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
