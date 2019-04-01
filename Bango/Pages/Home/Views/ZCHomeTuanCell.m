//
//  ZCHomeTuanCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeTuanCell.h"

@implementation ZCHomeTuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:[self subStacks]];
        stack.axis = UILayoutConstraintAxisVertical;
        stack.alignment = UIStackViewAlignmentFill;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.spacing = WidthRatio(5);
        [self.contentView addSubview:stack];
        
        [stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}


- (NSArray *)buttons {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UITool imageButton:ImageNamed(@"list_placeholder_normal") cornerRadius:WidthRatio(4) borderWidth:0.f borderColor:[UIColor clearColor]];
        [array addObject:button];
    }
    
    return array.copy;
}

- (NSArray *)subStacks {
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < 2; i++) {
        UIStackView *subStack = [[UIStackView alloc] initWithArrangedSubviews:[self buttons]];
        subStack.axis = UILayoutConstraintAxisHorizontal;
        subStack.alignment = UIStackViewAlignmentFill;
        subStack.distribution = UIStackViewDistributionFillEqually;
        subStack.spacing = WidthRatio(5);
        [array addObject:subStack];
    }
    return array.copy;
}


@end
