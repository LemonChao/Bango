//
//  ZCPersonalDataCollectionCell.m
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalDataCollectionCell.h"
#import "UIButton+EdgeInsets.h"

@interface ZCPersonalDataCollectionCell ()

@property(nonatomic, strong) UIButton *button;

@end


@implementation ZCPersonalDataCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.button = [UITool richButton:UIButtonTypeCustom title:nil titleColor:ImportantColor font:[UIFont systemFontOfSize:WidthRatio(14)] bgColor:[UIColor clearColor] image:nil];
        self.button.userInteractionEnabled = YES;
        [self.contentView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title image:(NSString *)imageName {
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setImage:ImageNamed(imageName) forState:UIControlStateNormal];
    
    [self.button setImagePosition:ZCImagePositionTop spacing:WidthRatio(14)];
}

@end
