//
//  ZCHomeCategoryCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeCategoryCell.h"
#import "UIButton+EdgeInsets.h"
#import "ZCCategoryCollectionCell.h"

@interface ZCHomeCategoryCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) UIStackView *stack;

@end

static NSString *cellid = @"ZCCategoryCollectionCell_id";

@implementation ZCHomeCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), 0, WidthRatio(12)));
        }];

        
//        self.stack = [[UIStackView alloc] initWithArrangedSubviews:[self buttons]];
//        self.stack.axis = UILayoutConstraintAxisHorizontal;
//        self.stack.alignment = UIStackViewAlignmentFill;
//        self.stack.distribution = UIStackViewDistributionFillEqually;
//        self.stack.spacing = WidthRatio(30);
//        [self.contentView addSubview:self.stack];
//
//        [self.stack mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(24), 0, WidthRatio(24)));
//        }];
    }
    
    return self;
    
    
}



- (void)setCategoryList:(NSArray<__kindof ZCHomeCategoryModel *> *)categoryList {
    _categoryList = categoryList;
    
    [self.collectionView reloadData];
    
    
//    for (UIButton *subButton in self.stack.subviews) {
//
//        NSUInteger index = [self.stack.subviews indexOfObject:subButton];
//        ZCHomeCategoryModel *model = self.categoryList[index];
//
//        @weakify(subButton);
//        [subButton setImageWithURL:[NSURL URLWithString:model.category_pic] forState:UIControlStateNormal placeholder:nil options:YYWebImageOptionShowNetworkActivity  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [subButton_weak_ setImage:image forState:UIControlStateNormal];
//                [subButton_weak_ setTitle:model.category_name forState:UIControlStateNormal];
//                [subButton_weak_ setImagePosition:ZCImagePositionTop spacing:6];
//            });
//        }];
//
//    }
    
}


- (void)categoryButtonAction:(UIButton *)button {
    if (self.buttonBlock) {
        
        NSUInteger index = [self.stack.subviews indexOfObject:button];
        ZCHomeCategoryModel *model = self.categoryList[index];
        self.buttonBlock(model);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WidthRatio(125), WidthRatio(125));
        layout.minimumInteritemSpacing = WidthRatio(5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZCCategoryCollectionCell class] forCellWithReuseIdentifier:cellid];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}



- (NSArray *)buttons {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UITool richButton:UIButtonTypeCustom title:@"shuiguo" titleColor:ImportantColor font:MediumFont(14) bgColor:[UIColor clearColor] image:ImageNamed(@"list_placeholder_normal")];
//        [button addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:button];
    }
    
    return array.copy;
}


@end
