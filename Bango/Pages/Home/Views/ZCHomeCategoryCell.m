//
//  ZCHomeCategoryCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeCategoryCell.h"

@implementation ZCHomeCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:[self buttons]];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.alignment = UIStackViewAlignmentFill;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.spacing = WidthRatio(30);
        [self.contentView addSubview:stack];
        
        [stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(24), 0, WidthRatio(24)));
        }];
    }
    
    return self;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSArray *)buttons {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UITool richButton:UIButtonTypeCustom title:@"" titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor] image:ImageNamed(@"")];
        [array addObject:button];
    }
    
    return array.copy;
}


@end
