//
//  CustomRefreshGifHeader.h
//  HuoJianJiSong
//
//  Created by Apple on 2017/12/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MJRefreshGifHeader.h"

@interface CustomRefreshGifHeader : MJRefreshGifHeader
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end
