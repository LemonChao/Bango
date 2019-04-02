//
//  ZCCategoryCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/2.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCCategoryCollectionCell.h"

@interface ZCCategoryCollectionCell ()

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UILabel *nameLab;

@end

@implementation ZCCategoryCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.imgView = [UITool imageViewImage:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeBottom];
//        self.nameLab = [UITool labelWithTextColor:<#(nonnull UIColor *)#> font:<#(nonnull UIFont *)#>]
    }
    return self;
}






- (UIImageView *)imgView {
    if (!_imgView) {
//        _imgView = [UITool imageViewImage:ImageNamed(@"list_placeholder_normal") contentMode:UIViewContentModeBottom];
    }
    return _imgView;
}


@end
