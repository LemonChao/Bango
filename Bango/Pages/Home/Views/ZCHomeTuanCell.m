//
//  ZCHomeTuanCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeTuanCell.h"

@interface ZCHomeTuanCell ()

@property(nonatomic, strong) UIStackView *stack;

@end

@implementation ZCHomeTuanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.stack = [[UIStackView alloc] initWithArrangedSubviews:[self subStacks]];
        self.stack.axis = UILayoutConstraintAxisVertical;
        self.stack.alignment = UIStackViewAlignmentFill;
        self.stack.distribution = UIStackViewDistributionFillEqually;
        self.stack.spacing = WidthRatio(5);
        [self.contentView addSubview:self.stack];
        
        [self.stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setPintuanList:(NSArray<__kindof ZCHomePintuanModel *> *)pintuanList {
    _pintuanList = pintuanList;
    
//    for (UIStackView *subStack in self.stack.subviews) {
//        [subStack.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
//            ZCHomePintuanModel *model =pintuanList[idx];
//
//            [button setImageWithURL:[NSURL URLWithString:model.pic_cover_mid] forState:UIControlStateNormal options:YYWebImageOptionShowNetworkActivity];
//        }];
//    }
    
    [self.stack.subviews enumerateObjectsUsingBlock:^(__kindof UIStackView * _Nonnull subStack, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [subStack.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger index, BOOL * _Nonnull stop) {
            NSLog(@"index:%lu", 2*idx + index);
            ZCHomePintuanModel *model = pintuanList[2*idx + index];
            
            [button setImageWithURL:[NSURL URLWithString:model.pic_cover_mid] forState:UIControlStateNormal options:YYWebImageOptionShowNetworkActivity];
        }];
    }];

}

- (void)tuanButtonAction:(UIButton *)button {
    
//    for (UIStackView *subStack in self.stack.subviews) {
//        [subStack.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
//            ZCHomePintuanModel *model =pintuanList[idx];
//
//            [button setImageWithURL:[NSURL URLWithString:model.pic_cover_mid] forState:UIControlStateNormal options:YYWebImageOptionShowNetworkActivity];
//        }];
//    }
    
    [self.stack.subviews enumerateObjectsUsingBlock:^(__kindof UIStackView * _Nonnull subStack, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [subStack.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull button, NSUInteger index, BOOL * _Nonnull stop) {
            
            if (self.buttonBlock) {
                ZCHomePintuanModel *model =self.pintuanList[2*idx + index];
                self.buttonBlock(model);
            }
            
        }];
    }];
    
    
    
    
}

- (NSArray *)buttons {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UITool imageButton:ImageNamed(@"list_placeholder_normal") cornerRadius:WidthRatio(4) borderWidth:0.f borderColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(tuanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
