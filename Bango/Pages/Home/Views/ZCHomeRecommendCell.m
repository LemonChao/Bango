//
//  ZCHomeRecommendCell.m
//  Bango
//
//  Created by zchao on 2019/3/30.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomeRecommendCell.h"
#import "ZCHomeRecommendCollectionCell.h"

@interface ZCHomeRecommendCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *collectionView;


@end

static NSString *cellid = @"ZCHomeRecommendCollectionCell_id";

@implementation ZCHomeRecommendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), 0, 0));
        }];
    }
    
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCHomeRecommendCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    return cell;
}



- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WidthRatio(125), WidthRatio(125));
        layout.minimumInteritemSpacing = WidthRatio(5);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZCHomeRecommendCollectionCell class] forCellWithReuseIdentifier:cellid];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
@end
