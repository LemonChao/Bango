//
//  ZCPersonalDataCell.m
//  Bango
//
//  Created by zchao on 2019/4/9.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCPersonalDataCell.h"
#import "ZCPersonalDataCollectionCell.h"

@interface ZCPersonalDataCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, copy) NSArray *dataArray;

@end

@implementation ZCPersonalDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [UITool viewWithColor:[UIColor whiteColor]];
        UIView *lineView = [UITool viewWithColor:LineColor];

        [self.contentView addSubview:bgView];
        [bgView addSubview:self.titleLable];
        [bgView addSubview:self.collectionView];
        [bgView addSubview:lineView];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, WidthRatio(12), 0, WidthRatio(12)));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).inset(WidthRatio(10));
            make.top.equalTo(bgView).inset(WidthRatio(13));
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).inset(WidthRatio(40));
            make.left.right.bottom.equalTo(bgView);
        }];

        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).inset(WidthRatio(40));
            make.left.right.equalTo(bgView);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZCPersonalDataCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    NSDictionary *info = self.dataArray[indexPath.row];
    [cell setTitle:info[@"title"] image:info[@"imageName"]];
    return cell;
}


#pragma mark - setter && getter

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithText:@"我的资料" textColor:PrimaryColor font:BoldFont(WidthRatio(17))];
    }
    return _titleLable;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(WidthRatio(87), WidthRatio(87));
        layout.minimumLineSpacing = 1.f;
        layout.minimumInteritemSpacing = 1.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[ZCPersonalDataCollectionCell class] forCellWithReuseIdentifier:@"cell_id"];
        _collectionView.backgroundColor = LineColor;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSArray *titles = @[@"个人资料",@"实名认证",@"分享好友",@"收货地址",@"我的拼团",@"我的优惠券",@"我的收藏",@"我的足迹"];
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:titles.count];

        for (int i = 0; i < titles.count; i++) {
            NSString *imageName = StringFormat(@"personal_data%d", i);
            NSDictionary *dic = @{@"imageName":imageName,@"title":titles[i]};
            [mArray addObject:dic];
        }
        _dataArray = mArray.copy;
    }
    return _dataArray;
}


@end
