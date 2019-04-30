//
//  UIView+BadgeValue.m
//  Bango
//
//  Created by zchao on 2019/4/28.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "UIView+BadgeValue.h"

@interface UIView ()

@property(nonatomic, strong) UILabel *badgelabel;

@end

static void *badgeValueKey = &badgeValueKey;

@implementation UIView (BadgeValue)

+ (void)load {
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
//                                       class_getInstanceMethod(self.class, @selector(badgeValue_swizzing_layoutSubviews)));
        
    });
    
    
}


- (void)badgeValue_swizzing_layoutSubviews {
    if (self.badgelabel) {
        CGSize size = [self.badgelabel intrinsicContentSize];
        self.badgelabel.frame = CGRectMake(CGRectGetWidth(self.frame)-size.width, 0, size.width, 12);
    }
    
    [self badgeValue_swizzing_layoutSubviews];
}

- (void)updateBadgeLabel {
    if (self.badgeValue) {
        self.badgelabel.text = self.badgeValue;
        
        CGSize size = [self.badgelabel intrinsicContentSize];
        if (self.badgeValue.integerValue == 0) {
            size = CGSizeMake(8, 8);
            self.badgelabel.layer.cornerRadius = 4.f;
        }else if (self.badgeValue.integerValue < 10){
            size = CGSizeMake(12, 12);
            self.badgelabel.layer.cornerRadius = 6.f;

        }else {
            size = CGSizeMake(size.width+8, 12);
            self.badgelabel.layer.cornerRadius = 6.f;
        }

        self.badgelabel.frame = CGRectMake(CGRectGetWidth(self.frame)-size.width, 0, size.width, size.height);
        
        [self insertSubview:self.badgelabel atIndex:0];

    }else {
        self.badgelabel.frame = CGRectZero;
    }
}



#pragma mark - setter && getter

- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, &badgeValueKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue.integerValue < 0) {
        badgeValue = nil;
    }else if (badgeValue.integerValue == 0) {
        badgeValue = @"";
    }
    objc_setAssociatedObject(self, &badgeValueKey, badgeValue, OBJC_ASSOCIATION_COPY);
    [self layoutIfNeeded];
    [self updateBadgeLabel];
}

- (UILabel *)badgelabel {
    UILabel *badgeLab = objc_getAssociatedObject(self, @selector(badgelabel));

    if (!badgeLab) {
        badgeLab = [[UILabel alloc] init];
        badgeLab.backgroundColor = GeneralRedColor;
        badgeLab.textColor = [UIColor whiteColor];
        badgeLab.font = [UIFont systemFontOfSize:11];
        badgeLab.textAlignment = NSTextAlignmentCenter;
        badgeLab.layer.cornerRadius = 6.f;
        badgeLab.clipsToBounds = YES;
        objc_setAssociatedObject(self, @selector(badgelabel), badgeLab, OBJC_ASSOCIATION_RETAIN);
    }
    return badgeLab;
}
@end
